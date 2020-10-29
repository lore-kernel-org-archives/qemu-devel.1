Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70769C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC9320757
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hupW7B/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC9320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3Ng-0001W0-DT
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1kY3MI-0000r5-Vd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1kY3MG-0000BZ-8W
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603960350;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=Q6CoOKo+rcMH0+8F24rLtzf8Y4ZcT+zOilM9FHtn280=;
 b=hupW7B/BqeS63REk5Mwn4BDjOi2GijRiQnL9U1LXssODlsJ/WZKmImQnwT6oCuBtszl5NF
 v2rOhEMK9WJMz35Zxa1joXNKgtQA0iYUHRM5Y9NVyj7yUzsosAEM4BVvv9k+R1z7EHSLzu
 fVbQy0CvXOM9ZTaXakLbWd5eonhMAsE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-QoKfHlC9Mp6xiUUrfMzKOw-1; Thu, 29 Oct 2020 04:32:23 -0400
X-MC-Unique: QoKfHlC9Mp6xiUUrfMzKOw-1
Received: by mail-wr1-f72.google.com with SMTP id x16so960055wrg.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:sender:message-id:date
 :subject:from:to;
 bh=Bz6GyBzH4eSzflO589RaQ3UdZvpcza4pvdiXgdIQfAY=;
 b=Q/zsGm+lxpgDUm+c7snFiutcn2BQ8giMho6ee7qsJyQe/uV/gfV7Kexob8gB9lY+PF
 J718NE80PXUl/BYtyb0CQlg1aIYhQ6pSAI13ApPAVI4xzOfpLexTQ8gtbAn2Z0fXLxY1
 EKKQmqmRqZVII6PbyOZEcxkfDbLh4eeGrFfvLc+Gf4xVOGN6ECORwN88Z6EuN5J8/T5x
 eHH5u8Wc+v2h8BBQXKu23nOnBs1Erra8gXewUCl3BFnfbNNzUsCbGEgRB+DMqnqjfdQa
 j4ZRLLWJARBdUWsPkzRlONS+tOMwwSYARfjvF7WUJGS4dUzRCh78O+WSdbIxeLJxRd+6
 SiWQ==
X-Gm-Message-State: AOAM5324u1VbkwVlwoJMVabAzdBDOQAGGABJ2n1gyJuPSyx6Ebicf77k
 bpcWn+FW8/d6hmWFFX+8TO1ScL9dH9t7ama9AVRmwBUjKe5XZ6geeBZam2BPuqF2Jtp887X42vL
 epSTQMpoH8MxJ2MAZjEhxPbqoHa+OoiOf
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr3004281wmr.179.1603960342059; 
 Thu, 29 Oct 2020 01:32:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhssWkLeiXRDTlbYdWr/krhQToBwOPSplcByOWEvOtz1LxJlpt3GyAudZMC03/bZL5LBtrH2Kq1O8SIcqHcXvS
MIME-Version: 1.0
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr3004272wmr.179.1603960341821; 
 Thu, 29 Oct 2020 01:32:21 -0700 (PDT)
Message-ID: <00000000000068994d05b2cb1efc@google.com>
Date: Thu, 29 Oct 2020 08:32:21 +0000
Subject: Invitation: VIRTIO - KVM Forum 2020 Birds of a Feather session @ Thu
 Oct 29, 2020 12:00 - 13:00 (GMT) (qemu-devel@nongnu.org)
From: shajnocz@redhat.com
To: qemu-devel@nongnu.org, cohuck@redhat.com, mst@redhat.com, 
 pasic@linux.ibm.com, jan.kiszka@siemens.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=shajnocz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="00000000000068993105b2cb1efb"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=shajnocz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000068993105b2cb1efb
Content-Type: multipart/alternative; boundary="00000000000068992f05b2cb1ef9"

--00000000000068992f05b2cb1ef9
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

WW91IGhhdmUgYmVlbiBpbnZpdGVkIHRvIHRoZSBmb2xsb3dpbmcgZXZlbnQuDQoNClRpdGxlOiBW
SVJUSU8gLSBLVk0gRm9ydW0gMjAyMCBCaXJkcyBvZiBhIEZlYXRoZXIgc2Vzc2lvbg0KDQpEaXNj
dXNzaW9uIGF0IEtWTSBGb3J1bSAyMDIwIGFib3V0IFZJUlRJTyB0b3BpY3MuIFNwZWMgY2hhbmdl
cywgbmV3ICANCmRldmljZXMsIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucywgZXRjLg0KDQpBbnlv
bmUgaXMgd2VsY29tZSB0byBqb2luIQ0KDQpNZWV0aW5nIFVSTDogaHR0cHM6Ly9tZWV0Lmdvb2ds
ZS5jb20vc3ptLWtkdmEtemtzDQpXaGVuOiBUaHUgT2N0IDI5LCAyMDIwIDEyOjAwIOKAkyAxMzow
MCBVbml0ZWQgS2luZ2RvbSBUaW1lDQpDYWxlbmRhcjogcWVtdS1kZXZlbEBub25nbnUub3JnDQpX
aG86DQogICAgICogc2hham5vY3pAcmVkaGF0LmNvbSAtIG9yZ2FuaXplcg0KICAgICAqIGNvaHVj
a0ByZWRoYXQuY29tDQogICAgICogbXN0QHJlZGhhdC5jb20NCiAgICAgKiBwYXNpY0BsaW51eC5p
Ym0uY29tDQogICAgICogamFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KICAgICAqIHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KDQpFdmVudCBkZXRhaWxzOiAgDQpodHRwczovL3d3dy5nb29nbGUuY29tL2Nh
bGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1NMnR2Y1dWcU5EQTJOalppTTJwME16ZzJaMncy
TW1acWNuUWdjV1Z0ZFMxa1pYWmxiRUJ1YjI1bmJuVXViM0puJnRvaz1NVGtqYzJoaGFtNXZZM3BB
Y21Wa2FHRjBMbU52YldSbU56UTRPVFl3T1Rsa05EWmpaREl5TVdWaE1UaGtOekJsTURoa1pHRXlO
REEwTURWa1pEZyZjdHo9RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVzPTANCg0KSW52aXRhdGlvbiBm
cm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0K
WW91IGFyZSByZWNlaXZpbmcgdGhpcyBjb3VydGVzeSBlbWFpbCBhdCB0aGUgYWNjb3VudCBxZW11
LWRldmVsQG5vbmdudS5vcmcgIA0KYmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9mIHRoaXMg
ZXZlbnQuDQoNClRvIHN0b3AgcmVjZWl2aW5nIGZ1dHVyZSB1cGRhdGVzIGZvciB0aGlzIGV2ZW50
LCBkZWNsaW5lIHRoaXMgZXZlbnQuICANCkFsdGVybmF0aXZlbHkgeW91IGNhbiBzaWduIHVwIGZv
ciBhIEdvb2dsZSBhY2NvdW50IGF0ICANCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vY2FsZW5kYXIv
IGFuZCBjb250cm9sIHlvdXIgbm90aWZpY2F0aW9uIHNldHRpbmdzIGZvciAgDQp5b3VyIGVudGly
ZSBjYWxlbmRhci4NCg0KRm9yd2FyZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cgYW55
IHJlY2lwaWVudCB0byBzZW5kIGEgcmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciBhbmQgYmUg
YWRkZWQgdG8gdGhlIGd1ZXN0IGxpc3QsIG9yIGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyAgDQpv
ZiB0aGVpciBvd24gaW52aXRhdGlvbiBzdGF0dXMsIG9yIHRvIG1vZGlmeSB5b3VyIFJTVlAuIExl
YXJuIG1vcmUgYXQgIA0KaHR0cHM6Ly9zdXBwb3J0Lmdvb2dsZS5jb20vY2FsZW5kYXIvYW5zd2Vy
LzM3MTM1I2ZvcndhcmRpbmcNCg==
--00000000000068992f05b2cb1ef9
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
gleCalendar" content=3D"3koqej40666b3jt386gl62fjrt"/><h3 style=3D"padding:0=
 0 6px 0;margin:0;font-family:Arial,Sans-serif;font-size:16px;font-weight:b=
old;color:#222"><span itemprop=3D"name">VIRTIO - KVM Forum 2020 Birds of a =
Feather session</span></h3><table style=3D"display:inline-table" cellpaddin=
g=3D"0" cellspacing=3D"0" border=3D"0" summary=3D"Event details"><tr><td st=
yle=3D"padding:0 1em 10px 0;font-family:Arial,Sans-serif;font-size:13px;col=
or:#888;white-space:nowrap;width:90px" valign=3D"top"><div><i style=3D"font=
-style:normal">When</i></div></td><td style=3D"padding-bottom:10px;font-fam=
ily:Arial,Sans-serif;font-size:13px;color:#222" valign=3D"top"><div style=
=3D"text-indent:-1px"><time itemprop=3D"startDate" datetime=3D"20201029T120=
000Z"></time><time itemprop=3D"endDate" datetime=3D"20201029T130000Z"></tim=
e>Thu Oct 29, 2020 12:00 =E2=80=93 13:00 <span style=3D"color:#888">United =
Kingdom Time</span></div></td></tr><tr><td style=3D"padding:0 1em 10px 0;fo=
nt-family:Arial,Sans-serif;font-size:13px;color:#888;white-space:nowrap;wid=
th:90px" valign=3D"top"><div><i style=3D"font-style:normal">Calendar</i></d=
iv></td><td style=3D"padding-bottom:10px;font-family:Arial,Sans-serif;font-=
size:13px;color:#222" valign=3D"top"><div style=3D"text-indent:-1px">qemu-d=
evel@nongnu.org</div></td></tr><tr><td style=3D"padding:0 1em 10px 0;font-f=
amily:Arial,Sans-serif;font-size:13px;color:#888;white-space:nowrap;width:9=
0px" valign=3D"top"><div><i style=3D"font-style:normal">Who</i></div></td><=
td style=3D"padding-bottom:10px;font-family:Arial,Sans-serif;font-size:13px=
;color:#222" valign=3D"top"><table cellspacing=3D"0" cellpadding=3D"0"><tr>=
<td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px=
;color:#222;width:10px"><div style=3D"text-indent:-1px"><span style=3D"font=
-family:Courier New,monospace">&#x2022;</span></div></td><td style=3D"paddi=
ng-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div =
style=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate">shajnocz@redhat.com</span><meta itemp=
rop=3D"email" content=3D"shajnocz@redhat.com"/></span><span itemprop=3D"org=
anizer" itemscope itemtype=3D"http://schema.org/Person"><meta itemprop=3D"n=
ame" content=3D"shajnocz@redhat.com"/><meta itemprop=3D"email" content=3D"s=
hajnocz@redhat.com"/></span><span style=3D"font-size:11px;color:#888"> - or=
ganizer</span></div></div></div></td></tr><tr><td style=3D"padding-right:10=
px;font-family:Arial,Sans-serif;font-size:13px;color:#222;width:10px"><div =
style=3D"text-indent:-1px"><span style=3D"font-family:Courier New,monospace=
">&#x2022;</span></div></td><td style=3D"padding-right:10px;font-family:Ari=
al,Sans-serif;font-size:13px;color:#222"><div style=3D"text-indent:-1px"><d=
iv><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate">cohuck@redhat.com</span><meta itemprop=3D"email" content=3D"cohuck=
@redhat.com"/></span></div></div></div></td></tr><tr><td style=3D"padding-r=
ight:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222;width:10px=
"><div style=3D"text-indent:-1px"><span style=3D"font-family:Courier New,mo=
nospace">&#x2022;</span></div></td><td style=3D"padding-right:10px;font-fam=
ily:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"text-indent:-=
1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate">mst@redhat.com</span><meta itemprop=3D"email" content=3D"m=
st@redhat.com"/></span></div></div></div></td></tr><tr><td style=3D"padding=
-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#222;width:10=
px"><div style=3D"text-indent:-1px"><span style=3D"font-family:Courier New,=
monospace">&#x2022;</span></div></td><td style=3D"padding-right:10px;font-f=
amily:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"text-indent=
:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate">pasic@linux.ibm.com</span><meta itemprop=3D"email" conten=
t=3D"pasic@linux.ibm.com"/></span></div></div></div></td></tr><tr><td style=
=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#2=
22;width:10px"><div style=3D"text-indent:-1px"><span style=3D"font-family:C=
ourier New,monospace">&#x2022;</span></div></td><td style=3D"padding-right:=
10px;font-family:Arial,Sans-serif;font-size:13px;color:#222"><div style=3D"=
text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0"><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate">jan.kiszka@siemens.com</span><meta itemprop=3D=
"email" content=3D"jan.kiszka@siemens.com"/></span></div></div></div></td><=
/tr><tr><td style=3D"padding-right:10px;font-family:Arial,Sans-serif;font-s=
ize:13px;color:#222;width:10px"><div style=3D"text-indent:-1px"><span style=
=3D"font-family:Courier New,monospace">&#x2022;</span></div></td><td style=
=3D"padding-right:10px;font-family:Arial,Sans-serif;font-size:13px;color:#2=
22"><div style=3D"text-indent:-1px"><div><div style=3D"margin:0 0 0.3em 0">=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate">qemu-devel@nongnu.org</span>=
<meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span></div></=
div></div></td></tr></table></td></tr></table><div style=3D"float:right;fon=
t-weight:bold;font-size:13px"> <a href=3D"https://www.google.com/calendar/e=
vent?action=3DVIEW&amp;eid=3DM2tvcWVqNDA2NjZiM2p0Mzg2Z2w2MmZqcnQgcWVtdS1kZX=
ZlbEBub25nbnUub3Jn&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWRmNzQ4OTYwOTlkND=
ZjZDIyMWVhMThkNzBlMDhkZGEyNDA0MDVkZDg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den=
&amp;es=3D0" style=3D"color:#20c;white-space:nowrap" itemprop=3D"url">more =
details &raquo;</a><br></div><div style=3D"padding-bottom:15px;font-family:=
Arial,Sans-serif;font-size:13px;color:#222;white-space:pre-wrap!important;w=
hite-space:-moz-pre-wrap!important;white-space:-pre-wrap!important;white-sp=
ace:-o-pre-wrap!important;white-space:pre;word-wrap:break-word"><span><br>D=
iscussion at KVM Forum 2020 about VIRTIO topics. Spec changes, new devices,=
 hardware implementations, etc.<p>Anyone is welcome to join!</p><p>Meeting =
URL: <a href=3D"https://meet.google.com/szm-kdva-zks" target=3D"_blank">htt=
ps://meet.google.com/szm-kdva-zks</a></p></span><meta itemprop=3D"descripti=
on" content=3D"
Discussion at KVM Forum 2020 about VIRTIO topics. Spec changes, new devices=
, hardware implementations, etc.

Anyone is welcome to join!

Meeting URL: https://meet.google.com/szm-kdva-zks"/></div></div><p style=3D=
"color:#222;font-size:13px;margin:0"><span style=3D"color:#888">Going (qemu=
-devel@nongnu.org)?&nbsp;&nbsp;&nbsp;</span><wbr><strong><span itemprop=3D"=
potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta =
itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><=
span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActio=
nHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMe=
thod/GET"/><a href=3D"https://www.google.com/calendar/event?action=3DRESPON=
D&amp;eid=3DM2tvcWVqNDA2NjZiM2p0Mzg2Z2w2MmZqcnQgcWVtdS1kZXZlbEBub25nbnUub3J=
n&amp;rst=3D1&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWRmNzQ4OTYwOTlkNDZjZDI=
yMWVhMThkNzBlMDhkZGEyNDA0MDVkZDg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;=
es=3D0" style=3D"color:#20c;white-space:nowrap" itemprop=3D"url">Yes</a></s=
pan></span><span style=3D"margin:0 0.4em;font-weight:normal"> - </span><spa=
n itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/Rsvp=
Action"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAtte=
ndance/Maybe"/><span itemprop=3D"handler" itemscope itemtype=3D"http://sche=
ma.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.o=
rg/HttpRequestMethod/GET"/><a href=3D"https://www.google.com/calendar/event=
?action=3DRESPOND&amp;eid=3DM2tvcWVqNDA2NjZiM2p0Mzg2Z2w2MmZqcnQgcWVtdS1kZXZ=
lbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWRmNzQ=
4OTYwOTlkNDZjZDIyMWVhMThkNzBlMDhkZGEyNDA0MDVkZDg&amp;ctz=3DEurope%2FLondon&=
amp;hl=3Den&amp;es=3D0" style=3D"color:#20c;white-space:nowrap" itemprop=3D=
"url">Maybe</a></span></span><span style=3D"margin:0 0.4em;font-weight:norm=
al"> - </span><span itemprop=3D"potentialaction" itemscope itemtype=3D"http=
://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://s=
chema.org/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope itemtype=
=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D"=
http://schema.org/HttpRequestMethod/GET"/><a href=3D"https://www.google.com=
/calendar/event?action=3DRESPOND&amp;eid=3DM2tvcWVqNDA2NjZiM2p0Mzg2Z2w2MmZq=
cnQgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D2&amp;tok=3DMTkjc2hham5vY3pAcmVk=
aGF0LmNvbWRmNzQ4OTYwOTlkNDZjZDIyMWVhMThkNzBlMDhkZGEyNDA0MDVkZDg&amp;ctz=3DE=
urope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"color:#20c;white-space:nowr=
ap" itemprop=3D"url">No</a></span></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;<=
wbr><a href=3D"https://www.google.com/calendar/event?action=3DVIEW&amp;eid=
=3DM2tvcWVqNDA2NjZiM2p0Mzg2Z2w2MmZqcnQgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=
=3DMTkjc2hham5vY3pAcmVkaGF0LmNvbWRmNzQ4OTYwOTlkNDZjZDIyMWVhMThkNzBlMDhkZGEy=
NDA0MDVkZDg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"colo=
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
--00000000000068992f05b2cb1ef9
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20201029T120000Z
DTEND:20201029T130000Z
DTSTAMP:20201029T083221Z
ORGANIZER;CN=shajnocz@redhat.com:mailto:shajnocz@redhat.com
UID:3koqej40666b3jt386gl62fjrt@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=shajnocz@redhat.com;X-NUM-GUESTS=0:mailto:shajnocz@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cohuck@redhat.com;X-NUM-GUESTS=0:mailto:cohuck@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mst@redhat.com;X-NUM-GUESTS=0:mailto:mst@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pasic@linux.ibm.com;X-NUM-GUESTS=0:mailto:pasic@linux.ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jan.kiszka@siemens.com;X-NUM-GUESTS=0:mailto:jan.kiszka@siemens.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
X-MICROSOFT-CDO-OWNERAPPTID:-2054373051
CREATED:20201029T083219Z
DESCRIPTION:\nDiscussion at KVM Forum 2020 about VIRTIO topics. Spec change
 s\, new devices\, hardware implementations\, etc.\n\nAnyone is welcome to j
 oin!\n\nMeeting URL: https://meet.google.com/szm-kdva-zks\n\n-::~:~::~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\n
 Please do not edit this section of the description.\n\nView your event at h
 ttps://www.google.com/calendar/event?action=VIEW&eid=M2tvcWVqNDA2NjZiM2p0Mz
 g2Z2w2MmZqcnQgcWVtdS1kZXZlbEBub25nbnUub3Jn&tok=MTkjc2hham5vY3pAcmVkaGF0LmNv
 bWRmNzQ4OTYwOTlkNDZjZDIyMWVhMThkNzBlMDhkZGEyNDA0MDVkZDg&ctz=Europe%2FLondon
 &hl=en&es=1.\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20201029T083219Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:VIRTIO - KVM Forum 2020 Birds of a Feather session
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--00000000000068992f05b2cb1ef9--

--00000000000068993105b2cb1efb
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjAxMDI5VDEyMDAwMFoNCkRURU5EOjIwMjAxMDI5
VDEzMDAwMFoNCkRUU1RBTVA6MjAyMDEwMjlUMDgzMjIxWg0KT1JHQU5JWkVSO0NOPXNoYWpub2N6
QHJlZGhhdC5jb206bWFpbHRvOnNoYWpub2N6QHJlZGhhdC5jb20NClVJRDoza29xZWo0MDY2NmIz
anQzODZnbDYyZmpydEBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049c2hham5v
Y3pAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c2hham5vY3pAcmVkaGF0LmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jb2h1Y2tAcmVkaGF0LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86Y29odWNrQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049bXN0QHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1zdEByZWRoYXQuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBhc2ljQGxpbnV4LmlibS5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOnBhc2ljQGxpbnV4LmlibS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049amFuLmtpc3prYUBzaWVtZW5zLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amFuLmtp
c3prYUBzaWVtZW5zLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1xZW11LWRldmVs
QG5vbmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K
WC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi0yMDU0MzczMDUxDQpDUkVBVEVEOjIwMjAxMDI5
VDA4MzIxOVoNCkRFU0NSSVBUSU9OOlxuRGlzY3Vzc2lvbiBhdCBLVk0gRm9ydW0gMjAyMCBhYm91
dCBWSVJUSU8gdG9waWNzLiBTcGVjIGNoYW5nZQ0KIHNcLCBuZXcgZGV2aWNlc1wsIGhhcmR3YXJl
IGltcGxlbWVudGF0aW9uc1wsIGV0Yy5cblxuQW55b25lIGlzIHdlbGNvbWUgdG8gag0KIG9pbiFc
blxuTWVldGluZyBVUkw6IGh0dHBzOi8vbWVldC5nb29nbGUuY29tL3N6bS1rZHZhLXprc1xuXG4t
Ojp+On46On46fjp+Og0KIH46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46Oi1cbg0KIFBsZWFzZSBkbyBub3QgZWRpdCB0
aGlzIHNlY3Rpb24gb2YgdGhlIGRlc2NyaXB0aW9uLlxuXG5WaWV3IHlvdXIgZXZlbnQgYXQgaA0K
IHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TTJ0
dmNXVnFOREEyTmpaaU0ycDBNeg0KIGcyWjJ3Mk1tWnFjblFnY1dWdGRTMWtaWFpsYkVCdWIyNW5i
blV1YjNKbiZ0b2s9TVRramMyaGhhbTV2WTNwQWNtVmthR0YwTG1Odg0KIGJXUm1OelE0T1RZd09U
bGtORFpqWkRJeU1XVmhNVGhrTnpCbE1EaGtaR0V5TkRBME1EVmtaRGcmY3R6PUV1cm9wZSUyRkxv
bmRvbg0KICZobD1lbiZlcz0xLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fg0KIDp+On46fjp+On46fjp+On46fjo6fjp+OjotDQpM
QVNULU1PRElGSUVEOjIwMjAxMDI5VDA4MzIxOVoNCkxPQ0FUSU9OOg0KU0VRVUVOQ0U6MA0KU1RB
VFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpWSVJUSU8gLSBLVk0gRm9ydW0gMjAyMCBCaXJkcyBvZiBh
IEZlYXRoZXIgc2Vzc2lvbg0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRB
Ug0K
--00000000000068993105b2cb1efb--


