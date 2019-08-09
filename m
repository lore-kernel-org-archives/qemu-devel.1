Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAFD2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAFD2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvxFN-0003oJ-As
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 01:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hvxEH-0003J7-B8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hvxEG-0003MU-9W
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:14:17 -0400
Resent-Date: Fri, 09 Aug 2019 01:14:17 -0400
Resent-Message-Id: <E1hvxEG-0003MU-9W@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hvxEG-0003J1-1k; Fri, 09 Aug 2019 01:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565327646; cv=none; d=zoho.com; s=zohoarc; 
 b=ffOvaKg1g4VOnWr2xCtKQee2TiS9fge3V/nUpxa1X8zM0A2/qax2+Ma+0lmgzzKASt0tSZ5TNsVjoIxKGZgN33Ibz68F3mIIjjbaVhG+qfQnbSF1tk2TibWRW0mOmHjft2scRZe2PU6/bFWZcLb8KfotTCtSfiK2t+/Px5XEKs0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565327646;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=SLH2Zf2+ApKlpaCtdSLJN6M7y+5Xhk/o4Ijng6kaguY=; 
 b=Sqbrbwg+9EF3YSvf67aqQLyHNxgMN3lJFzvLIiCS1rAoAPuGIXA9JK7SQkSvy8aXyVTdy/lIZ0PggYY/SmqKoyD/6G/i6IkgpcyoUUPqOwFagGx9ZZiI/BNZyRc63/IYnjhEPyAS1RE14oxB274JzHzSuAJdb5BFq7HbpRKe1aw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565327645137271.8518030906167;
 Thu, 8 Aug 2019 22:14:05 -0700 (PDT)
In-Reply-To: <20190809042909.74988-1-rebecca@bsdio.com>
Message-ID: <156532764399.12874.720972209018325901@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rebecca@bsdio.com
Date: Thu, 8 Aug 2019 22:14:05 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v2] Update the avx2 configure test to be
 compatible with clang
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
Cc: qemu-trivial@nongnu.org, rebecca@bsdio.com, mjt@tls.msk.ru,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwOTA0MjkwOS43NDk4
OC0xLXJlYmVjY2FAYnNkaW8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2Ug
ZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdXRpbC9vc2xpYi1w
b3NpeC5vCiAgQ0MgICAgICB1dGlsL3FlbXUtb3BlbnB0eS5vCiAgQ0MgICAgICB1dGlsL3FlbXUt
dGhyZWFkLXBvc2l4Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvYnVmZmVyaXN6ZXJvLmM6NzE6
MTM6IGVycm9yOiB1bmtub3duIHByYWdtYSBpZ25vcmVkIFstV2Vycm9yLC1XdW5rbm93bi1wcmFn
bWFzXQojcHJhZ21hIEdDQyBwdXNoX29wdGlvbnMKICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVz
dC9zcmMvdXRpbC9idWZmZXJpc3plcm8uYzo3MjoxMzogZXJyb3I6IHVua25vd24gcHJhZ21hIGln
bm9yZWQgWy1XZXJyb3IsLVd1bmtub3duLXByYWdtYXNdCiNwcmFnbWEgR0NDIHRhcmdldCgic3Nl
MiIpCiAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvYnVmZmVyaXN6ZXJvLmM6
MTA4OjEzOiBlcnJvcjogdW5rbm93biBwcmFnbWEgaWdub3JlZCBbLVdlcnJvciwtV3Vua25vd24t
cHJhZ21hc10KI3ByYWdtYSBHQ0MgcG9wX29wdGlvbnMKICAgICAgICAgICAgXgovdG1wL3FlbXUt
dGVzdC9zcmMvdXRpbC9idWZmZXJpc3plcm8uYzoxMTY6MTM6IGVycm9yOiB1bmtub3duIHByYWdt
YSBpZ25vcmVkIFstV2Vycm9yLC1XdW5rbm93bi1wcmFnbWFzXQojcHJhZ21hIEdDQyBwdXNoX29w
dGlvbnMKICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9idWZmZXJpc3plcm8u
YzoxMTc6MTM6IGVycm9yOiB1bmtub3duIHByYWdtYSBpZ25vcmVkIFstV2Vycm9yLC1XdW5rbm93
bi1wcmFnbWFzXQojcHJhZ21hIEdDQyB0YXJnZXQoInNzZTQiKQogICAgICAgICAgICBeCi90bXAv
cWVtdS10ZXN0L3NyYy91dGlsL2J1ZmZlcmlzemVyby5jOjE0ODoxMzogZXJyb3I6IHVua25vd24g
cHJhZ21hIGlnbm9yZWQgWy1XZXJyb3IsLVd1bmtub3duLXByYWdtYXNdCiNwcmFnbWEgR0NDIHBv
cF9vcHRpb25zCiAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvYnVmZmVyaXN6
ZXJvLmM6MTQ5OjEzOiBlcnJvcjogdW5rbm93biBwcmFnbWEgaWdub3JlZCBbLVdlcnJvciwtV3Vu
a25vd24tcHJhZ21hc10KI3ByYWdtYSBHQ0MgcHVzaF9vcHRpb25zCiAgICAgICAgICAgIF4KL3Rt
cC9xZW11LXRlc3Qvc3JjL3V0aWwvYnVmZmVyaXN6ZXJvLmM6MTUwOjEzOiBlcnJvcjogdW5rbm93
biBwcmFnbWEgaWdub3JlZCBbLVdlcnJvciwtV3Vua25vd24tcHJhZ21hc10KI3ByYWdtYSBHQ0Mg
dGFyZ2V0KCJhdngyIikKICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9idWZm
ZXJpc3plcm8uYzoxODc6MTM6IGVycm9yOiB1bmtub3duIHByYWdtYSBpZ25vcmVkIFstV2Vycm9y
LC1XdW5rbm93bi1wcmFnbWFzXQojcHJhZ21hIEdDQyBwb3Bfb3B0aW9ucwogICAgICAgICAgICBe
CjkgZXJyb3JzIGdlbmVyYXRlZC4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODA5MDQyOTA5Ljc0OTg4LTEtcmViZWNjYUBic2Rpby5j
b20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


