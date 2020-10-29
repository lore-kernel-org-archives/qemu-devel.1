Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B399C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E614C20732
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qu6EU3Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E614C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3Bo-0004Gq-SF
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1kY3B2-0003pn-Ax
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1kY3Az-0004Te-HV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603959651;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=1x1J/FBWK4JQEFQ4t5kP0/6Y7NhXRxdqpNgD1lyAHZ4=;
 b=Qu6EU3Xy52rHQdcSawyHdbF3KMUu1Jfh5RNPOUuY7tKkzb+EJejSKzfGrb0mlKLC6cNWQP
 x/atLtfwQVDIMVkOC3R1HpHaBqBd2sl1LM4ma7awT4T701cWuIierDZ+VIovPE14JgJcP8
 pfifT6EBNe9KkfGXuLjDpgIOOVybEss=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-OcbukwjUMWiwkvBLkmGxJA-1; Thu, 29 Oct 2020 04:20:46 -0400
X-MC-Unique: OcbukwjUMWiwkvBLkmGxJA-1
Received: by mail-lj1-f200.google.com with SMTP id i3so963269lja.15
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:sender:message-id:date
 :subject:from:to;
 bh=RewFCrCgnh6kSLVS0VJcrMYDGa+oRVRKNcW6zveNHWc=;
 b=T6vAy2sZOH9feCcWdn7iNdKNvXpe0o69P9d6K0+JoUJ5ygo89lOFECza3AirpUSWx/
 Qznj+Cpb4v3JHAkqjt1CPY92m9Z356pR0sN3g7ytCj5Rnz/LmEK6f5tukfAp6xQGaIOJ
 C3SJy1JagG3CoRd8ki945LQGkqKw48njeIC64e1ur7tzgcRIVFcYZT3EhYZgq0n+neCi
 bQM+vGavp5e4ERMEbY7cbg4gcfk+MA5JGFonS6K1u3kDJCErogppTt76qY+VXL2vbPvx
 4OnYpd9ZE4CZKlJDYGqYsBiFdkTnSnasZYxxoqR/oRVHGz7AjlyEXQIDEaF+XWdXBN0r
 /VGg==
X-Gm-Message-State: AOAM533UfnM0YkF3xOl1VN9vWoTI4m8TrKfhLoxlMnKAIDhxcfvpclhA
 bqyAt1h6fDBa/x/as1JXnlfUmS1lqZ9dNFfTY16o1OxFiZM9h4qBWOXIBSAKz1Hn7cMvUneyKbc
 9YGAudEnCyeOaYyY5Jh9tg6L5wUXeRsXY
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr1263703ljj.463.1603959644822; 
 Thu, 29 Oct 2020 01:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3RE0RBSMpbZ7gXC2pVLbhtsn9SR77bGcIMIG1mrHMTrxH0/IMMmOkVBjnSgshUii2vkUD/bun49SEB1/A90rq
MIME-Version: 1.0
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr1263696ljj.463.1603959644544; 
 Thu, 29 Oct 2020 01:20:44 -0700 (PDT)
Message-ID: <000000000000d92aac05b2caf476@google.com>
Date: Thu, 29 Oct 2020 08:20:44 +0000
Subject: Invitation: Out-of-Process Device Emulation - KVM Forum 2020 Birds
 of... @ Thu Oct 29, 2020 11:00 - 12:00 (GMT) (qemu-devel@nongnu.org)
From: shajnocz@redhat.com
To: qemu-devel@nongnu.org, mtsirkin@redhat.com, 
 Felipe Franciosi <felipe@nutanix.com>, elena.ufimtseva@oracle.com,
 thanos.makatos@nutanix.com, 
 david@gibson.dropbear.id.au, jag.raman@oracle.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, kraxel@redhat.com, 
 slp@redhat.com, marcandre.lureau@redhat.com, john.g.johnson@oracle.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=shajnocz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="000000000000d92a8c05b2caf475"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=shajnocz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, HTTPS_HTTP_MISMATCH=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: shajnocz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d92a8c05b2caf475
Content-Type: multipart/alternative; boundary="000000000000d92a8b05b2caf473"

--000000000000d92a8b05b2caf473
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

WW91IGhhdmUgYmVlbiBpbnZpdGVkIHRvIHRoZSBmb2xsb3dpbmcgZXZlbnQuDQoNClRpdGxlOiBP
dXQtb2YtUHJvY2VzcyBEZXZpY2UgRW11bGF0aW9uIC0gS1ZNIEZvcnVtIDIwMjAgQmlyZHMgb2Yg
YSBGZWF0aGVyICANCnNlc3Npb24NCg0KV2Ugd2lsbCBkaXNjdXNzIG91dC1vZi1wcm9jZXNzIGRl
dmljZSBlbXVsYXRpb24gaW4gUUVNVS4gVGhpcyBpbmNsdWRlcyAgDQptdWx0aS1wcm9jZXNzIFFF
TVUsIHZmaW8tdXNlciwgdmhvc3QtdXNlciwgYW5kIHJlbGF0ZWQgcHJvamVjdHMuDQoNCkFueW9u
ZSBjYW4gcGFydGljaXBhdGUhDQoNCk1lZXRpbmcgVVJMOiBodHRwczovL21lZXQuaml0LnNpL1FF
TVVPb1BEZXZpY2VzDQpXaGVuOiBUaHUgT2N0IDI5LCAyMDIwIDExOjAwIOKAkyAxMjowMCBVbml0
ZWQgS2luZ2RvbSBUaW1lDQpDYWxlbmRhcjogcWVtdS1kZXZlbEBub25nbnUub3JnDQpXaG86DQog
ICAgICogc2hham5vY3pAcmVkaGF0LmNvbSAtIG9yZ2FuaXplcg0KICAgICAqIG10c2lya2luQHJl
ZGhhdC5jb20NCiAgICAgKiBGZWxpcGUgRnJhbmNpb3NpDQogICAgICogZWxlbmEudWZpbXRzZXZh
QG9yYWNsZS5jb20NCiAgICAgKiBxZW11LWRldmVsQG5vbmdudS5vcmcNCiAgICAgKiB0aGFub3Mu
bWFrYXRvc0BudXRhbml4LmNvbQ0KICAgICAqIGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQ0K
ICAgICAqIGphZy5yYW1hbkBvcmFjbGUuY29tDQogICAgICogQWxleCBCZW5uw6llDQogICAgICog
a3JheGVsQHJlZGhhdC5jb20NCiAgICAgKiBzbHBAcmVkaGF0LmNvbQ0KICAgICAqIG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbQ0KICAgICAqIGpvaG4uZy5qb2huc29uQG9yYWNsZS5jb20NCg0K
RXZlbnQgZGV0YWlsczogIA0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9h
Y3Rpb249VklFVyZlaWQ9Tm5CalpqaHphbUZqWXpoc2FtUnhiR2cyY1hWa2MyeHBaMllnY1dWdGRT
MWtaWFpsYkVCdWIyNW5iblV1YjNKbiZ0b2s9TVRramMyaGhhbTV2WTNwQWNtVmthR0YwTG1OdmJX
VTRaREl6TWpBMk1qTXdOVEZpTURWall6VXlObU5tWTJWa1lUWmlaRGhpTWpRNVpqbGpaR0kmY3R6
PUV1cm9wZSUyRkxvbmRvbiZobD1lbiZlcz0wDQoNCkludml0YXRpb24gZnJvbSBHb29nbGUgQ2Fs
ZW5kYXI6IGh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2
aW5nIHRoaXMgY291cnRlc3kgZW1haWwgYXQgdGhlIGFjY291bnQgcWVtdS1kZXZlbEBub25nbnUu
b3JnICANCmJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvZiB0aGlzIGV2ZW50Lg0KDQpUbyBz
dG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3IgdGhpcyBldmVudCwgZGVjbGluZSB0aGlz
IGV2ZW50LiAgDQpBbHRlcm5hdGl2ZWx5IHlvdSBjYW4gc2lnbiB1cCBmb3IgYSBHb29nbGUgYWNj
b3VudCBhdCAgDQpodHRwczovL3d3dy5nb29nbGUuY29tL2NhbGVuZGFyLyBhbmQgY29udHJvbCB5
b3VyIG5vdGlmaWNhdGlvbiBzZXR0aW5ncyBmb3IgIA0KeW91ciBlbnRpcmUgY2FsZW5kYXIuDQoN
CkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFueSByZWNpcGllbnQgdG8g
c2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIgYW5kIGJlIGFkZGVkIHRvIHRoZSBn
dWVzdCBsaXN0LCBvciBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3MgIA0Kb2YgdGhlaXIgb3duIGlu
dml0YXRpb24gc3RhdHVzLCBvciB0byBtb2RpZnkgeW91ciBSU1ZQLiBMZWFybiBtb3JlIGF0ICAN
Cmh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3YXJk
aW5nDQo=
--000000000000d92a8b05b2caf473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<span itemscope itemtype=3D"http://schema.org/InformAction"><span style=3D"=
display:none" itemprop=3D"about" itemscope itemtype=3D"http://schema.org/Pe=
rson"><meta itemprop=3D"description" content=3D"Invitation from shajnocz@re=
dhat.com"/></span><span itemprop=3D"object" itemscope itemtype=3D"http://sc=
hema.org/Event"><div style=3D""><table cellspacing=3D"0" cellpadding=3D"8" =
border=3D"0" summary=3D"" style=3D"width:100%;font-family:Arial,Sans-serif;=
border:1px Solid #ccc;border-width:1px 2px 2px 1px;background-color:#fff;">=
<tr><td><meta itemprop=3D"eventStatus" content=3D"http://schema.org/EventSc=
heduled"/><h4 style=3D"padding:6px 0;margin:0 0 4px 0;font-family:Arial,San=
s-serif;font-size:13px;line-height:1.4;border:1px Solid #fff;background:#ff=
f;color:#090;font-weight:normal"><strong>You have been invited to the follo=
wing event.</strong></h4><div style=3D"padding:2px"><span itemprop=3D"publi=
sher" itemscope itemtype=3D"http://schema.org/Organization"><meta itemprop=
=3D"name" content=3D"Google Calendar"/></span><meta itemprop=3D"eventId/goo=
gleCalendar" content=3D"6pcf8sjacc8ljdqlh6qudsligf"/><h3 style=3D"padding:0=
 0 6px 0;margin:0;font-family:Arial,Sans-serif;font-size:16px;font-weight:b=
old;color:#222"><span itemprop=3D"name">Out-of-Process Device Emulation - K=
VM Forum 2020 Birds of a Feather session</span></h3><table style=3D"display=
:inline-table" cellpadding=3D"0" cellspacing=3D"0" border=3D"0" summary=3D"=
Event details"><tr><td style=3D"padding:0 1em 10px 0;font-family:Arial,Sans=
-serif;font-size:13px;color:#888;white-space:nowrap;width:90px" valign=3D"t=
op"><div><i style=3D"font-style:normal">When</i></div></td><td style=3D"pad=
ding-bottom:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222" va=
lign=3D"top"><div style=3D"text-indent:-1px"><time itemprop=3D"startDate" d=
atetime=3D"20201029T110000Z"></time><time itemprop=3D"endDate" datetime=3D"=
20201029T120000Z"></time>Thu Oct 29, 2020 11:00 =E2=80=93 12:00 <span style=
=3D"color:#888">United Kingdom Time</span></div></td></tr><tr><td style=3D"=
padding:0 1em 10px 0;font-family:Arial,Sans-serif;font-size:13px;color:#888=
;white-space:nowrap;width:90px" valign=3D"top"><div><i style=3D"font-style:=
normal">Calendar</i></div></td><td style=3D"padding-bottom:10px;font-family=
:Arial,Sans-serif;font-size:13px;color:#222" valign=3D"top"><div style=3D"t=
ext-indent:-1px">qemu-devel@nongnu.org</div></td></tr><tr><td style=3D"padd=
ing:0 1em 10px 0;font-family:Arial,Sans-serif;font-size:13px;color:#888;whi=
te-space:nowrap;width:90px" valign=3D"top"><div><i style=3D"font-style:norm=
al">Who</i></div></td><td style=3D"padding-bottom:10px;font-family:Arial,Sa=
ns-serif;font-size:13px;color:#222" valign=3D"top"><table cellspacing=3D"0"=
 cellpadding=3D"0"><tr><td style=3D"padding-right:10px;font-family:Arial,Sa=
ns-serif;font-size:13px;color:#222;width:10px"><div style=3D"text-indent:-1=
px"><span style=3D"font-family:Courier New,monospace">&#x2022;</span></div>=
</td><td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size=
:13px;color:#222"><div style=3D"text-indent:-1px"><div><div style=3D"margin=
:0 0 0.3em 0"><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate">shajnocz@redha=
t.com</span><meta itemprop=3D"email" content=3D"shajnocz@redhat.com"/></spa=
n><span itemprop=3D"organizer" itemscope itemtype=3D"http://schema.org/Pers=
on"><meta itemprop=3D"name" content=3D"shajnocz@redhat.com"/><meta itemprop=
=3D"email" content=3D"shajnocz@redhat.com"/></span><span style=3D"font-size=
:11px;color:#888"> - organizer</span></div></div></div></td></tr><tr><td st=
yle=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color=
:#222;width:10px"><div style=3D"text-indent:-1px"><span style=3D"font-famil=
y:Courier New,monospace">&#x2022;</span></div></td><td style=3D"padding-rig=
ht:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div style=
=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate">mtsirkin@redhat.com</span><meta itemprop=
=3D"email" content=3D"mtsirkin@redhat.com"/></span></div></div></div></td><=
/tr><tr><td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-s=
ize:13px;color:#222;width:10px"><div style=3D"text-indent:-1px"><span style=
=3D"font-family:Courier New,monospace">&#x2022;</span></div></td><td style=
=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#2=
22"><div style=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0">=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate">Felipe Franciosi</span><meta=
 itemprop=3D"email" content=3D"felipe@nutanix.com"/></span></div></div></di=
v></td></tr><tr><td style=3D"padding-right:10px;font-family:Arial,Sans-seri=
f;font-size:13px;color:#222;width:10px"><div style=3D"text-indent:-1px"><sp=
an style=3D"font-family:Courier New,monospace">&#x2022;</span></div></td><t=
d style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;c=
olor:#222"><div style=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.=
3em 0"><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate">elena.ufimtseva@oracl=
e.com</span><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"=
/></span></div></div></div></td></tr><tr><td style=3D"padding-right:10px;fo=
nt-family:Arial,Sans-serif;font-size:13px;color:#222;width:10px"><div style=
=3D"text-indent:-1px"><span style=3D"font-family:Courier New,monospace">&#x=
2022;</span></div></td><td style=3D"padding-right:10px;font-family:Arial,Sa=
ns-serif;font-size:13px;color:#222"><div style=3D"text-indent:-1px"><div><d=
iv style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te">qemu-devel@nongnu.org</span><meta itemprop=3D"email" content=3D"qemu-de=
vel@nongnu.org"/></span></div></div></div></td></tr><tr><td style=3D"paddin=
g-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222;width:1=
0px"><div style=3D"text-indent:-1px"><span style=3D"font-family:Courier New=
,monospace">&#x2022;</span></div></td><td style=3D"padding-right:10px;font-=
family:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"text-inden=
t:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate">thanos.makatos@nutanix.com</span><meta itemprop=3D"email=
" content=3D"thanos.makatos@nutanix.com"/></span></div></div></div></td></t=
r><tr><td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-siz=
e:13px;color:#222;width:10px"><div style=3D"text-indent:-1px"><span style=
=3D"font-family:Courier New,monospace">&#x2022;</span></div></td><td style=
=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#2=
22"><div style=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0">=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate">david@gibson.dropbear.id.au<=
/span><meta itemprop=3D"email" content=3D"david@gibson.dropbear.id.au"/></s=
pan></div></div></div></td></tr><tr><td style=3D"padding-right:10px;font-fa=
mily:Arial,Sans-serif;font-size:13px;color:#222;width:10px"><div style=3D"t=
ext-indent:-1px"><span style=3D"font-family:Courier New,monospace">&#x2022;=
</span></div></td><td style=3D"padding-right:10px;font-family:Arial,Sans-se=
rif;font-size:13px;color:#222"><div style=3D"text-indent:-1px"><div><div st=
yle=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
>jag.raman@oracle.com</span><meta itemprop=3D"email" content=3D"jag.raman@o=
racle.com"/></span></div></div></div></td></tr><tr><td style=3D"padding-rig=
ht:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222;width:10px">=
<div style=3D"text-indent:-1px"><span style=3D"font-family:Courier New,mono=
space">&#x2022;</span></div></td><td style=3D"padding-right:10px;font-famil=
y:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"text-indent:-1p=
x"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate">Alex Benn=C3=A9e</span><meta itemprop=3D"email" content=3D"al=
ex.bennee@linaro.org"/></span></div></div></div></td></tr><tr><td style=3D"=
padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222;w=
idth:10px"><div style=3D"text-indent:-1px"><span style=3D"font-family:Couri=
er New,monospace">&#x2022;</span></div></td><td style=3D"padding-right:10px=
;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"text=
-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate">kraxel@redhat.com</span><meta itemprop=3D"email" c=
ontent=3D"kraxel@redhat.com"/></span></div></div></div></td></tr><tr><td st=
yle=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color=
:#222;width:10px"><div style=3D"text-indent:-1px"><span style=3D"font-famil=
y:Courier New,monospace">&#x2022;</span></div></td><td style=3D"padding-rig=
ht:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div style=
=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate">slp@redhat.com</span><meta itemprop=3D"ema=
il" content=3D"slp@redhat.com"/></span></div></div></div></td></tr><tr><td =
style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;col=
or:#222;width:10px"><div style=3D"text-indent:-1px"><span style=3D"font-fam=
ily:Courier New,monospace">&#x2022;</span></div></td><td style=3D"padding-r=
ight:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div styl=
e=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate">marcandre.lureau@redhat.com</span><meta i=
temprop=3D"email" content=3D"marcandre.lureau@redhat.com"/></span></div></d=
iv></div></td></tr><tr><td style=3D"padding-right:10px;font-family:Arial,Sa=
ns-serif;font-size:13px;color:#222;width:10px"><div style=3D"text-indent:-1=
px"><span style=3D"font-family:Courier New,monospace">&#x2022;</span></div>=
</td><td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size=
:13px;color:#222"><div style=3D"text-indent:-1px"><div><div style=3D"margin=
:0 0 0.3em 0"><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate">john.g.johnson=
@oracle.com</span><meta itemprop=3D"email" content=3D"john.g.johnson@oracle=
.com"/></span></div></div></div></td></tr></table></td></tr></table><div st=
yle=3D"float:right;font-weight:bold;font-size:13px"> <a href=3D"https://www=
.google.com/calendar/event?action=3DVIEW&amp;eid=3DNnBjZjhzamFjYzhsamRxbGg2=
cXVkc2xpZ2YgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0=
LmNvbWU4ZDIzMjA2MjMwNTFiMDVjYzUyNmNmY2VkYTZiZDhiMjQ5ZjljZGI&amp;ctz=3DEurop=
e%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"color:#20c;white-space:nowrap" =
itemprop=3D"url">more details &raquo;</a><br></div><div style=3D"padding-bo=
ttom:15px;font-family:Arial,Sans-serif;font-size:13px;color:#222;white-spac=
e:pre-wrap!important;white-space:-moz-pre-wrap!important;white-space:-pre-w=
rap!important;white-space:-o-pre-wrap!important;white-space:pre;word-wrap:b=
reak-word"><span><br>We will discuss out-of-process device emulation in QEM=
U. This includes multi-process QEMU, vfio-user, vhost-user, and related pro=
jects.<p>Anyone can participate!</p><p>Meeting URL: <a href=3D"https://www.=
google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2FQEMUOoPDevices&amp;sa=3DD&am=
p;ust=3D1604391644315000&amp;usg=3DAOvVaw1lDkZSOllK9b7TdUibu4i9" target=3D"=
_blank">https://meet.jit.si/QEMUOoPDevices</a></p></span><meta itemprop=3D"=
description" content=3D"
We will discuss out-of-process device emulation in QEMU. This includes mult=
i-process QEMU, vfio-user, vhost-user, and related projects.

Anyone can participate!

Meeting URL: https://meet.jit.si/QEMUOoPDevices"/></div></div><p style=3D"c=
olor:#222;font-size:13px;margin:0"><span style=3D"color:#888">Going (qemu-d=
evel@nongnu.org)?&nbsp;&nbsp;&nbsp;</span><wbr><strong><span itemprop=3D"po=
tentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta it=
emprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><sp=
an itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionH=
andler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMeth=
od/GET"/><a href=3D"https://www.google.com/calendar/event?action=3DRESPOND&=
amp;eid=3DNnBjZjhzamFjYzhsamRxbGg2cXVkc2xpZ2YgcWVtdS1kZXZlbEBub25nbnUub3Jn&=
amp;rst=3D1&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWU4ZDIzMjA2MjMwNTFiMDVjY=
zUyNmNmY2VkYTZiZDhiMjQ5ZjljZGI&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=
=3D0" style=3D"color:#20c;white-space:nowrap" itemprop=3D"url">Yes</a></spa=
n></span><span style=3D"margin:0 0.4em;font-weight:normal"> - </span><span =
itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAc=
tion"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttend=
ance/Maybe"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema=
.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.org=
/HttpRequestMethod/GET"/><a href=3D"https://www.google.com/calendar/event?a=
ction=3DRESPOND&amp;eid=3DNnBjZjhzamFjYzhsamRxbGg2cXVkc2xpZ2YgcWVtdS1kZXZlb=
EBub25nbnUub3Jn&amp;rst=3D3&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWU4ZDIzM=
jA2MjMwNTFiMDVjYzUyNmNmY2VkYTZiZDhiMjQ5ZjljZGI&amp;ctz=3DEurope%2FLondon&am=
p;hl=3Den&amp;es=3D0" style=3D"color:#20c;white-space:nowrap" itemprop=3D"u=
rl">Maybe</a></span></span><span style=3D"margin:0 0.4em;font-weight:normal=
"> - </span><span itemprop=3D"potentialaction" itemscope itemtype=3D"http:/=
/schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://sch=
ema.org/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope itemtype=
=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D"=
http://schema.org/HttpRequestMethod/GET"/><a href=3D"https://www.google.com=
/calendar/event?action=3DRESPOND&amp;eid=3DNnBjZjhzamFjYzhsamRxbGg2cXVkc2xp=
Z2YgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D2&amp;tok=3DMTkjc2hham5vY3pAcmVk=
aGF0LmNvbWU4ZDIzMjA2MjMwNTFiMDVjYzUyNmNmY2VkYTZiZDhiMjQ5ZjljZGI&amp;ctz=3DE=
urope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"color:#20c;white-space:nowr=
ap" itemprop=3D"url">No</a></span></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;<=
wbr><a href=3D"https://www.google.com/calendar/event?action=3DVIEW&amp;eid=
=3DNnBjZjhzamFjYzhsamRxbGg2cXVkc2xpZ2YgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=
=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWU4ZDIzMjA2MjMwNTFiMDVjYzUyNmNmY2VkYTZiZDhi=
MjQ5ZjljZGI&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"colo=
r:#20c;white-space:nowrap" itemprop=3D"url">more options &raquo;</a></p></t=
d></tr><tr><td style=3D"background-color:#f6f6f6;color:#888;border-top:1px =
Solid #ccc;font-family:Arial,Sans-serif;font-size:11px"><p>Invitation from =
<a href=3D"https://www.google.com/calendar/" target=3D"_blank" style=3D"">G=
oogle Calendar</a></p><p>You are receiving this courtesy email at the accou=
nt qemu-devel@nongnu.org because you are an attendee of this event.</p><p>T=
o stop receiving future updates for this event, decline this event. Alterna=
tively you can sign up for a Google account at https://www.google.com/calen=
dar/ and control your notification settings for your entire calendar.</p><p=
>Forwarding this invitation could allow any recipient to send a response to=
 the organizer and be added to the guest list, or invite others regardless =
of their own invitation status, or to modify your RSVP. <a href=3D"https://=
support.google.com/calendar/answer/37135#forwarding">Learn More</a>.</p></t=
d></tr></table></div></span></span>
--000000000000d92a8b05b2caf473
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20201029T110000Z
DTEND:20201029T120000Z
DTSTAMP:20201029T082044Z
ORGANIZER;CN=shajnocz@redhat.com:mailto:shajnocz@redhat.com
UID:6pcf8sjacc8ljdqlh6qudsligf@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mtsirkin@redhat.com;X-NUM-GUESTS=0:mailto:mtsirkin@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Felipe Franciosi;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=elena.ufimtseva@oracle.com;X-NUM-GUESTS=0:mailto:elena.ufimtseva@or
 acle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=thanos.makatos@nutanix.com;X-NUM-GUESTS=0:mailto:thanos.makatos@nut
 anix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=david@gibson.dropbear.id.au;X-NUM-GUESTS=0:mailto:david@gibson.drop
 bear.id.au
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jag.raman@oracle.com;X-NUM-GUESTS=0:mailto:jag.raman@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=shajnocz@redhat.com;X-NUM-GUESTS=0:mailto:shajnocz@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=kraxel@redhat.com;X-NUM-GUESTS=0:mailto:kraxel@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=slp@redhat.com;X-NUM-GUESTS=0:mailto:slp@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=marcandre.lureau@redhat.com;X-NUM-GUESTS=0:mailto:marcandre.lureau@
 redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=john.g.johnson@oracle.com;X-NUM-GUESTS=0:mailto:john.g.johnson@orac
 le.com
X-MICROSOFT-CDO-OWNERAPPTID:-171259377
CREATED:20201029T082040Z
DESCRIPTION:\nWe will discuss out-of-process device emulation in QEMU. This
  includes multi-process QEMU\, vfio-user\, vhost-user\, and related project
 s.\n\nAnyone can participate!\n\nMeeting URL: https://meet.jit.si/QEMUOoPDe
 vices\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~::~:~::-\nPlease do not edit this section of the description.\
 n\nView your event at https://www.google.com/calendar/event?action=VIEW&eid
 =NnBjZjhzamFjYzhsamRxbGg2cXVkc2xpZ2YgcWVtdS1kZXZlbEBub25nbnUub3Jn&tok=MTkjc
 2hham5vY3pAcmVkaGF0LmNvbWU4ZDIzMjA2MjMwNTFiMDVjYzUyNmNmY2VkYTZiZDhiMjQ5Zjlj
 ZGI&ctz=Europe%2FLondon&hl=en&es=1.\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20201029T082041Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:Out-of-Process Device Emulation - KVM Forum 2020 Birds of a Feather
  session
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--000000000000d92a8b05b2caf473--

--000000000000d92a8c05b2caf475
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjAxMDI5VDExMDAwMFoNCkRURU5EOjIwMjAxMDI5
VDEyMDAwMFoNCkRUU1RBTVA6MjAyMDEwMjlUMDgyMDQ0Wg0KT1JHQU5JWkVSO0NOPXNoYWpub2N6
QHJlZGhhdC5jb206bWFpbHRvOnNoYWpub2N6QHJlZGhhdC5jb20NClVJRDo2cGNmOHNqYWNjOGxq
ZHFsaDZxdWRzbGlnZkBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW10
c2lya2luQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm10c2lya2luQHJlZGhhdC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RmVsaXBlIEZyYW5jaW9zaTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86ZmVsaXBlQG51dGFuaXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpl
bGVuYS51ZmltdHNldmFAb3INCiBhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1xZW11LWRldmVsQG5vbmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj10aGFub3MubWFrYXRvc0Bu
dXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86dGhhbm9zLm1ha2F0b3NAbnV0DQogYW5p
eC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZGF2aWRAZ2lic29uLmRyb3BiZWFy
LmlkLmF1O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkYXZpZEBnaWJzb24uZHJvcA0KIGJlYXIuaWQu
YXUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amFnLnJhbWFuQG9yYWNsZS5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmphZy5yYW1hbkBvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1B
Q0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049c2hham5vY3pAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86c2hham5vY3pAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1rcmF4ZWxAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a3JheGVsQHJlZGhhdC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c2xwQHJlZGhhdC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOnNscEByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFyY2Fu
ZHJlLmx1cmVhdUANCiByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpv
aG4uZy5qb2huc29uQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpvaG4uZy5qb2hu
c29uQG9yYWMNCiBsZS5jb20NClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotMTcxMjU5Mzc3
DQpDUkVBVEVEOjIwMjAxMDI5VDA4MjA0MFoNCkRFU0NSSVBUSU9OOlxuV2Ugd2lsbCBkaXNjdXNz
IG91dC1vZi1wcm9jZXNzIGRldmljZSBlbXVsYXRpb24gaW4gUUVNVS4gVGhpcw0KICBpbmNsdWRl
cyBtdWx0aS1wcm9jZXNzIFFFTVVcLCB2ZmlvLXVzZXJcLCB2aG9zdC11c2VyXCwgYW5kIHJlbGF0
ZWQgcHJvamVjdA0KIHMuXG5cbkFueW9uZSBjYW4gcGFydGljaXBhdGUhXG5cbk1lZXRpbmcgVVJM
OiBodHRwczovL21lZXQuaml0LnNpL1FFTVVPb1BEZQ0KIHZpY2VzXG5cbi06On46fjo6fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Og0KIH46
fjp+On46fjp+On46On46fjo6LVxuUGxlYXNlIGRvIG5vdCBlZGl0IHRoaXMgc2VjdGlvbiBvZiB0
aGUgZGVzY3JpcHRpb24uXA0KIG5cblZpZXcgeW91ciBldmVudCBhdCBodHRwczovL3d3dy5nb29n
bGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZA0KID1ObkJqWmpoemFtRmpZemhz
YW1SeGJHZzJjWFZrYzJ4cFoyWWdjV1Z0ZFMxa1pYWmxiRUJ1YjI1bmJuVXViM0puJnRvaz1NVGtq
Yw0KIDJoaGFtNXZZM3BBY21Wa2FHRjBMbU52YldVNFpESXpNakEyTWpNd05URmlNRFZqWXpVeU5t
Tm1ZMlZrWVRaaVpEaGlNalE1Wmpsag0KIFpHSSZjdHo9RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVz
PTEuXG4tOjp+On46On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Og0KIH46fjp+On46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46Oi0NCkxBU1QtTU9ESUZJRUQ6MjAy
MDEwMjlUMDgyMDQxWg0KTE9DQVRJT046DQpTRVFVRU5DRTowDQpTVEFUVVM6Q09ORklSTUVEDQpT
VU1NQVJZOk91dC1vZi1Qcm9jZXNzIERldmljZSBFbXVsYXRpb24gLSBLVk0gRm9ydW0gMjAyMCBC
aXJkcyBvZiBhIEZlYXRoZXINCiAgc2Vzc2lvbg0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0K
RU5EOlZDQUxFTkRBUg0K
--000000000000d92a8c05b2caf475--


