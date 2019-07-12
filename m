Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD86C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AC2208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AC2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwnt-00011L-He
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlwnh-0000cf-Sv
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlwnf-0003EC-PE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:45:29 -0400
Resent-Date: Fri, 12 Jul 2019 10:45:29 -0400
Resent-Message-Id: <E1hlwnf-0003EC-PE@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlwnf-0003Ac-0Y; Fri, 12 Jul 2019 10:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562942716; cv=none; d=zoho.com; s=zohoarc; 
 b=ExRrX+uA0Ve7p5uc94RzWIrOAjFDFFyWjW+l/AJpLqiVTpjXJzNzY+HKTvfNe1IM3hW6mmbw1GV7EHbG2DZd7lWPZQmeOpn5dea/MbQaqPCZ9gCZhnw93PDLiq0Z9TcoMRzKlU7/0YbmAdiNsO8+5Ss14A3eaRiwuDlvf5ABOyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562942716;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=4rWmxT/bo3BpSBW0jqj36TaaQslkwWBbyRH7bZ+O0lQ=; 
 b=N9TjqE18QS0m0Du78TxJWFOzRY9qDVLNpUnCQKWN/N0dD1xeMGBzoPf70hgk9FiwJTGXGmApcEni8dqxCGw+JvB9S6zQbTd8NVeJnOlJ5udi8wzeM0/ff1heg6j+6l49b2AAde09zLrtzZeS0fJlte0IpJgQCCC8xfd8K3lMz7k=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562942713607936.2627854646358;
 Fri, 12 Jul 2019 07:45:13 -0700 (PDT)
Message-ID: <156294271226.12463.2547812308422768411@c4a48874b076>
In-Reply-To: <20190711150940.17483-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Fri, 12 Jul 2019 07:45:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v3] LUKS: support preallocation
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mlevitsk@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMTE1MDk0MC4xNzQ4
My0xLW1sZXZpdHNrQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNzExMTUwOTQwLjE3NDgzLTEtbWxldml0c2tA
cmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10g
TFVLUzogc3VwcG9ydCBwcmVhbGxvY2F0aW9uCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpmMWIwOTA2Y2YzIExVS1M6
IHN1cHBvcnQgcHJlYWxsb2NhdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGJyYWNl
cyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNzM6IEZJ
TEU6IGJsb2NrL2NyeXB0by5jOjUyNjoKKyAgICBpZiAobHVrc19vcHRzLT5oYXNfcHJlYWxsb2Nh
dGlvbikKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCBmMWIwOTA2Y2YzYzkgKExVS1M6IHN1cHBvcnQgcHJlYWxsb2NhdGlvbikgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3MTExNTA5NDAuMTc0ODMtMS1tbGV2aXRza0ByZWRoYXQu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


