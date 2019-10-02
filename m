Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB6C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1125321929
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1125321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdN0-000791-6U
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFdLs-0006hJ-0T
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFdLq-0005vt-3k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:03:27 -0400
Resent-Date: Wed, 02 Oct 2019 08:03:27 -0400
Resent-Message-Id: <E1iFdLq-0005vt-3k@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFdLp-0005vO-SZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570017794; cv=none; d=zoho.com; s=zohoarc; 
 b=JaBAB3O53eXI+twe7UwLTV2681fdV5bjq4A1coWFxBkUwN0GClScfP2XryCSlX6FSjKzxphAXYNtdo0KSkFveK8/0xjjAufSeopNKfmaMfSMG+BtpFGbul08ALyHfnt0P/8WI7xnwjggJUmK1VwGHMSoQKtiuyfilsujtPROMk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570017794;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Gw6oCDtv90IH7R1TD3x06UdXZLuRdvFcowFXNQANXk4=; 
 b=E9RLkMkOm73s6tYpKNgNwKnRTrfHTPv4lNQGtwaoKkr+luWbcxEr435n5qJTHKOvqBrz8pRRZQjt5yCKxSnG0qB//VFhl6cjZCbqIdlhropWrUliFbl1MwcN0vamkWVy6wOPFB5NWnDY+ZzrMfz3MFGOEHlAuc962tU9UjEFzDM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570017793937704.2965819788811;
 Wed, 2 Oct 2019 05:03:13 -0700 (PDT)
Subject: Re: [PATCH v5 00/10] Introduce the microvm machine type
In-Reply-To: <20191002113103.45023-1-slp@redhat.com>
Message-ID: <157001779203.27524.4468384410902390930@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Wed, 2 Oct 2019 05:03:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Reply-To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMjExMzEwMy40NTAy
My0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRt
bXUvaHcvYXJtL3ZpcnQubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS92aXJ0LWFj
cGktYnVpbGQubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni94ZW4veGVuLWh2bS5jOiBJbiBm
dW5jdGlvbiAneGVuX3JhbV9pbml0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYveGVuL3hl
bi1odm0uYzoyMDM6NTM6IGVycm9yOiAnUENfTUFDSElORV9NQVhfUkFNX0JFTE9XXzRHJyB1bmRl
Y2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ19NQUNISU5FX01BWF9SQU1fQkVMT1df
NEcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni94ZW4veGVuLWh2bS5jOjIwMzo1Mzogbm90ZTog
ZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNo
IGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYveGVuL3hl
bi1odm0uYzoyMTc6MTM6IGVycm9yOiAnUENNYWNoaW5lU3RhdGUnIGhhcyBubyBtZW1iZXIgbmFt
ZWQgJ2Fib3ZlXzRnX21lbV9zaXplJwogICAgICAgICBwY21zLT5hYm92ZV80Z19tZW1fc2l6ZSA9
IHJhbV9zaXplIC0gdXNlcl9sb3dtZW07CiAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9pMzg2L3hlbi94ZW4taHZtLmM6MjE4OjEzOiBlcnJvcjogJ1BDTWFjaGluZVN0YXRlJyBo
YXMgbm8gbWVtYmVyIG5hbWVkICdiZWxvd180Z19tZW1fc2l6ZScKICAgICAgICAgcGNtcy0+YmVs
b3dfNGdfbWVtX3NpemUgPSB1c2VyX2xvd21lbTsKICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2kzODYveGVuL3hlbi1odm0uYzoyMjA6MTM6IGVycm9yOiAnUENNYWNoaW5lU3Rh
dGUnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2Fib3ZlXzRnX21lbV9zaXplJwogICAgICAgICBwY21z
LT5hYm92ZV80Z19tZW1fc2l6ZSA9IDA7CiAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9pMzg2L3hlbi94ZW4taHZtLmM6MjIxOjEzOiBlcnJvcjogJ1BDTWFjaGluZVN0YXRlJyBo
YXMgbm8gbWVtYmVyIG5hbWVkICdiZWxvd180Z19tZW1fc2l6ZScKICAgICAgICAgcGNtcy0+YmVs
b3dfNGdfbWVtX3NpemUgPSByYW1fc2l6ZTsKICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2kzODYveGVuL3hlbi1odm0uYzoyMjM6MTQ6IGVycm9yOiAnUENNYWNoaW5lU3RhdGUn
IGhhcyBubyBtZW1iZXIgbmFtZWQgJ2Fib3ZlXzRnX21lbV9zaXplJwogICAgIGlmICghcGNtcy0+
YWJvdmVfNGdfbWVtX3NpemUpIHsKICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9o
dy9pMzg2L3hlbi94ZW4taHZtLmM6MjMwOjQwOiBlcnJvcjogJ1BDTWFjaGluZVN0YXRlJyBoYXMg
bm8gbWVtYmVyIG5hbWVkICdhYm92ZV80Z19tZW1fc2l6ZScKICAgICAgICAgYmxvY2tfbGVuID0g
KDFVTEwgPDwgMzIpICsgcGNtcy0+YWJvdmVfNGdfbWVtX3NpemU7CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L3hlbi94
ZW4taHZtLmM6MjQ3OjM0OiBlcnJvcjogJ1BDTWFjaGluZVN0YXRlJyBoYXMgbm8gbWVtYmVyIG5h
bWVkICdiZWxvd180Z19tZW1fc2l6ZScKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNt
cy0+YmVsb3dfNGdfbWVtX3NpemUgLSAweGMwMDAwKTsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYveGVuL3hlbi1odm0uYzoyNDk6
MTM6IGVycm9yOiAnUENNYWNoaW5lU3RhdGUnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2Fib3ZlXzRn
X21lbV9zaXplJwogICAgIGlmIChwY21zLT5hYm92ZV80Z19tZW1fc2l6ZSA+IDApIHsKICAgICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYveGVuL3hlbi1odm0uYzoyNTI6Mzg6
IGVycm9yOiAnUENNYWNoaW5lU3RhdGUnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2Fib3ZlXzRnX21l
bV9zaXplJwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNtcy0+YWJvdmVfNGdf
bWVtX3NpemUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KbWFrZVsx
XTogKioqIFtody9pMzg2L3hlbi94ZW4taHZtLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L3Rhcmdl
dC9pMzg2L3RyYW5zbGF0ZS5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL2RpZ2lj
X2JvYXJkcy5vCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9yZWFsdmlldy5v
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL3Nic2EtcmVmLm8KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody9hcm0vc3RlbGxhcmlzLm8KbWFrZTogKioqIFt4ODZfNjQtc29mdG1t
dS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
ICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vY29sbGllLm8KICBDQyAgICAgIGFhcmNo
NjQtc29mdG1tdS9ody9hcm0vdmVyc2F0aWxlcGIubwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9ZjFjMmY3YzRjYzFiNGQzNjg1NjZmMDkzODZkYzM4ZWYnLCAnLXUnLCAn
MTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteW9lNzc2bncvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0w
Mi0wOC4wMC40Ny4xOTAzNzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZjFj
MmY3YzRjYzFiNGQzNjg1NjZmMDkzODZkYzM4ZWYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAteW9lNzc2bncvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50
b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtMjUuMzY1cwp1c2VyICAgIDBtNy44NjNzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAwMjEx
MzEwMy40NTAyMy0xLXNscEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


