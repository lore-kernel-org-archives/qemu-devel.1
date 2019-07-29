Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC98FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C414C206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C414C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrzNz-0005u8-2N
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 02:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hrzN9-0005V4-T7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hrzN8-0002xv-NE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:43:03 -0400
Resent-Date: Mon, 29 Jul 2019 02:43:03 -0400
Resent-Message-Id: <E1hrzN8-0002xv-NE@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hrzN8-0002oW-Dl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564382550; cv=none; d=zoho.com; s=zohoarc; 
 b=NpLjPqf6Kgz/3pfIne6z2olWJ5+KR5lUmjxjxHnO+BqnL4aUf/s81jNKKm4rLS6ZJ4sVKo0emiEKmt24smPbVVJYTUiVeTELFu+iuDW+7klum/Qldd+9HzSYr1GYt72zjDeCqXrLfj8mVF1FHiCTJybK29pjuTfx9Z25PhhsILI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564382550;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Ct6p9+pEGnmq6LAyPZVcE9QWuwAiC+o05gbDp+lrxQQ=; 
 b=JEyPz6hG9TpZxXdOz6i4Yk9hKYdN8+S0fcUsFBJ1FpluWLxzyfUA+dsX74ENM1typqX0V+ZtKklKH4UCZeejS7ZQEQk6+Rz/4Hu8yKbmwEQHdiVn6Z16/Ln+zhWA5H5Tgacn9mi7Jq0vYClQ3tfRDAy170YfRO8dKOUFYsZlnrs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1564382549497550.4488257715047;
 Sun, 28 Jul 2019 23:42:29 -0700 (PDT)
Message-ID: <156438254685.32054.9613015311594217315@c4a48874b076>
In-Reply-To: <156438176555.22071.10523120047318890136.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pavel.dovgaluk@gmail.com
Date: Sun, 28 Jul 2019 23:42:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com,
 artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, dovgaluk@ispras.ru, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, pavel.dovgaluk@ispras.ru,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY0MzgxNzY1NTUuMjIwNzEu
MTA1MjMxMjAwNDczMTg4OTAxMzYuc3RnaXRAcGFzaGEtUHJlY2lzaW9uLTM2MzAtVG93ZXIvCgoK
CkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNl
IGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hl
Y2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNo
ZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9
PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVj
aG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5hbWUgLWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxM
PSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApT
UkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RB
TEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNr
IC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
cmVwbGF5L3JlcGxheS1zbmFwc2hvdC5vCiAgQ0MgICAgICByZXBsYXkvcmVwbGF5LW5ldC5vCi92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16MmdmZzdhbC9zcmMvcmVwbGF5L3JlcGxheS1ldmVu
dHMuYzogSW4gZnVuY3Rpb24g4oCYcmVwbGF5X2JoX3NjaGVkdWxlX29uZXNob3RfZXZlbnTigJk6
Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16MmdmZzdhbC9zcmMvcmVwbGF5L3JlcGxheS1l
dmVudHMuYzoxNDE6MjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDi
gJhyZXBsYXlfZ2V0X2N1cnJlbnRfaWNvdW504oCZOyBkaWQgeW91IG1lYW4g4oCYcmVwbGF5X2dl
dF9jdXJyZW50X3N0ZXDigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQogIDE0MSB8ICAgICAgICAgdWludDY0X3QgaWQgPSByZXBsYXlfZ2V0X2N1cnJlbnRfaWNvdW50
KCk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgcmVwbGF5X2dldF9jdXJyZW50X3N0ZXAK
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXoyZ2ZnN2FsL3NyYy9yZXBsYXkvcmVwbGF5LWV2
ZW50cy5jOjE0MToyMzogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2Yg4oCYcmVw
bGF5X2dldF9jdXJyZW50X2ljb3VudOKAmSBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2MxOiBh
bGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtejJnZmc3YWwvc3JjL3J1bGVzLm1hazo2OTogcmVwbGF5L3JlcGxh
eS1ldmVudHMub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTU2NDM4MTc2NTU1LjIyMDcxLjEwNTIzMTIwMDQ3MzE4ODkwMTM2LnN0Z2l0QHBhc2hhLVBy
ZWNpc2lvbi0zNjMwLVRvd2VyL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


