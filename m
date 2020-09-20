Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1603CC43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9137820829
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9137820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3m7-0003la-PT
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK3gE-0007Ov-Oy
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 14:03:21 -0400
Resent-Date: Sun, 20 Sep 2020 14:03:18 -0400
Resent-Message-Id: <E1kK3gE-0007Ov-Oy@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK3gA-0003iV-UQ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 14:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600624984; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=btTk+k3fkocc7En+M5zuAkNRSMQ2x72JXLY2gwl0pswjuee4+4gPQbERAcW+WxjBjr+Mm/tfcbmosloN5g8/b2ohVssgV/XhEu95K5wJnMX4lPuFKRyFUptYh2N4sEwXRGadVA3Hral/0IFaW68+oJ0W40nDW7Nv6XA05sgMEBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600624984;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JTK7iI4BtKvu5RQE6CdIzhJTEefQ8bbYusgOF/e27Eo=; 
 b=MgtlVJQOU95Qh+u1TnW3yqtpoQj++PUvTQ0cB7swKbKWH0+HwbxHJuLM6DoDrjneHIEOLQjXk1LpEZ9eX8bGUZxanh23D5h2OPmoSS4ms7mLB1fzNw8MDJu/4nEXPH+JPzn6y4BOtYlXxNNRsW20L2S7AWB9PnvcGSUIkQXUUbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600624982573892.0258322654381;
 Sun, 20 Sep 2020 11:03:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] vhost-vdpa: add trace functions in vhost-vdpa.c
Message-ID: <160062498079.23907.15017544598835348843@66eaa9a8a123>
In-Reply-To: <20200920162434.868041-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lvivier@redhat.com
Date: Sun, 20 Sep 2020 11:03:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 14:03:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, lulu@redhat.com, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMDE2MjQzNC44Njgw
NDEtMS1sdml2aWVyQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyMDE2MjQzNC44Njgw
NDEtMS1sdml2aWVyQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIDAvMl0gdmhvc3QtdmRwYTog
YWRkIHRyYWNlIGZ1bmN0aW9ucyBpbiB2aG9zdC12ZHBhLmMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MjAxNzU4MjUuNDE3NjgwLTEtZjRidWdA
YW1zYXQub3JnIC0+IHBhdGNoZXcvMjAyMDA5MjAxNzU4MjUuNDE3NjgwLTEtZjRidWdAYW1zYXQu
b3JnCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvODRmMWM2MWEtODM5OS1jNzVlLTk2YzIt
ZmViZmMyZGQ1ZmFiQHQtb25saW5lLmRlIC0+IHBhdGNoZXcvODRmMWM2MWEtODM5OS1jNzVlLTk2
YzItZmViZmMyZGQ1ZmFiQHQtb25saW5lLmRlClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKMDhkMTAwMiB2aG9zdC12ZHBhOiBhZGQgdHJhY2UtZXZlbnRzCjdhYzZiMTEgdXRpbC9oZXhk
dW1wOiBpbnRyb2R1Y2UgcWVtdV9oZXhkdW1wX2xpbmUoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS8yIENoZWNraW5nIGNvbW1pdCA3YWM2YjExOTE5NTkgKHV0aWwvaGV4ZHVtcDogaW50cm9kdWNl
IHFlbXVfaGV4ZHVtcF9saW5lKCkpCjIvMiBDaGVja2luZyBjb21taXQgMDhkMTAwMjU0YzhiICh2
aG9zdC12ZHBhOiBhZGQgdHJhY2UtZXZlbnRzKQpFUlJPUjogSGV4IG51bWJlcnMgbXVzdCBiZSBw
cmVmaXhlZCB3aXRoICcweCcKIzI5OiBGSUxFOiBody92aXJ0aW8vdHJhY2UtZXZlbnRzOjMyOgor
dmhvc3RfdmRwYV9zZXRfbWVtX3RhYmxlKHZvaWQgKmRldiwgdWludDMyX3QgbnJlZ2lvbnMsIHVp
bnQzMl90IHBhZGRpbmcpICJkZXY6ICVwIG5yZWdpb25zOiAlIlBSSXUzMiIgcGFkZGluZzogJSJQ
Ukl4MzIKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzEyNjogRklM
RTogaHcvdmlydGlvL3Zob3N0LXZkcGEuYzoyNzU6CiteSWZvciAoaSA9IDA7IGkgPCBtZW0tPm5y
ZWdpb25zOyBpKyspIHskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJz
CiMxOTQ6IEZJTEU6IGh3L3ZpcnRpby92aG9zdC12ZHBhLmM6MzU1OgorXklxZW11X2hleGR1bXBf
bGluZShsaW5lLCBiLCBjb25maWcsIGxlbiwgZmFsc2UpOyQKCkVSUk9SOiBjb2RlIGluZGVudCBz
aG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE5NTogRklMRTogaHcvdmlydGlvL3Zob3N0LXZkcGEuYzoz
NTY6CiteSXRyYWNlX3Zob3N0X3ZkcGFfZHVtcF9jb25maWcoZGV2LCBsaW5lKTskCgpFUlJPUjog
Y29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyMTY6IEZJTEU6IGh3L3ZpcnRpby92
aG9zdC12ZHBhLmM6Mzc3OgorXkl2aG9zdF92ZHBhX2R1bXBfY29uZmlnKGRldiwgZGF0YSwgc2l6
ZSk7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjM1OiBGSUxF
OiBody92aXJ0aW8vdmhvc3QtdmRwYS5jOjQwMzoKK15Jdmhvc3RfdmRwYV9kdW1wX2NvbmZpZyhk
ZXYsIGNvbmZpZywgY29uZmlnX2xlbik7JAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzI1MTogRklMRTogaHcvdmlydGlvL3Zob3N0LXZkcGEuYzo0MzM6CisgICAgdHJhY2Vfdmhv
c3RfdmRwYV9zZXRfbG9nX2Jhc2UoZGV2LCBiYXNlLCBsb2ctPnNpemUsIGxvZy0+cmVmY250LCBs
b2ctPmZkLCBsb2ctPmxvZyk7Cgp0b3RhbDogNiBlcnJvcnMsIDEgd2FybmluZ3MsIDI5MSBsaW5l
cyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIwMTYyNDM0
Ljg2ODA0MS0xLWx2aXZpZXJAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

