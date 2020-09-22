Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B291720C09
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B291720C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKejm-0003Q4-Rn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKef5-00068P-Uy; Tue, 22 Sep 2020 05:32:35 -0400
Resent-Date: Tue, 22 Sep 2020 05:32:35 -0400
Resent-Message-Id: <E1kKef5-00068P-Uy@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKef3-00070Y-7V; Tue, 22 Sep 2020 05:32:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600767018; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KVpaG9bJ7mJffR86frelEdIv+WrkPlOtTUB1GBFksBD8EOnJffSahEX1YQs+DsFEvA0LsDCDXMgshCggRn6kHeRvriZissqgELgjwcpRV6ZAxqRaQxNp+nE4xRDXnrn9vou1MHlfQ9sXgtaaq2ToxWCgdMMANSpBGjFdsrqq9GU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600767018;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=D4DIMr06Njxf6DVvs7o1fUGh1IQ09kuy8PuWU3bfCAs=; 
 b=ZOCSrF5Bd2dq26J08o4XG+IEd3id3USxz1R1A9yS4X0CHf4BLYUloa4Msidb7SQ31RVBrvmTjVgR2JJvEiuJudRgM0JnX+frNFTmKYBxPrIUvUSziMui8EckkpVnhr0cpKRsLfcM/U5FVo/EGB6ClTaO14R8RIaaO4XtnREEbw8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600767016322169.2570710812787;
 Tue, 22 Sep 2020 02:30:16 -0700 (PDT)
Subject: Re: [PATCH v2] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
Message-ID: <160076700882.418.13612231969011652089@66eaa9a8a123>
In-Reply-To: <20200922085838.230505-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Tue, 22 Sep 2020 02:30:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:44:09
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
Cc: fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, jcmvbkbc@gmail.com,
 Alistair.Francis@wdc.com, kraxel@redhat.com, chenhc@lemote.com, jslaby@suse.cz,
 sstabellini@kernel.org, berto@igalia.com, sagark@eecs.berkeley.edu,
 ysato@users.sourceforge.jp, quintela@redhat.com, paul@xen.org,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 aleksandar.qemu.devel@gmail.com, anthony.perard@citrix.com,
 namei.unix@gmail.com, rth@twiddle.net, mjrosato@linux.ibm.com,
 thuth@redhat.com, ehabkost@redhat.com, sw@weilnetz.de, pl@kamp.de,
 dgilbert@redhat.com, yuval.shaia.ml@gmail.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 qemu-riscv@nongnu.org, sunilmut@microsoft.com, jsnow@redhat.com,
 zhang.zhanghailiang@huawei.com, xen-devel@lists.xenproject.org,
 kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 mreitz@redhat.com, palmer@dabbelt.com, pbonzini@redhat.com,
 aleksandar.rikalo@syrmia.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMjA4NTgzOC4yMzA1
MDUtMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA5MjIwODU4MzguMjMw
NTA1LTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjJdIHFlbXUvYXRvbWlj
Lmg6IHByZWZpeCBxZW11XyB0byBzb2x2ZSA8c3RkYXRvbWljLmg+IGNvbGxpc2lvbnMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwOTIy
MDg1ODM4LjIzMDUwNS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDkyMjA4
NTgzOC4yMzA1MDUtMS1zdGVmYW5oYUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKMWU2NDU3ZCBxZW11L2F0b21pYy5oOiBwcmVmaXggcWVtdV8gdG8gc29sdmUgPHN0
ZGF0b21pYy5oPiBjb2xsaXNpb25zCgo9PT0gT1VUUFVUIEJFR0lOID09PQpXQVJOSU5HOiBCbG9j
ayBjb21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzI1MDE6IEZJ
TEU6IGh3L3ZpcnRpby92aG9zdC5jOjkyOgorICAgICAgICAgKiBidXQgaXQncyBlYXNpZXIgdG8g
dXNlIHFlbXVfYXRvbWljXyogdGhhbiByb2xsIG91ciBvd24uICovCgpFUlJPUjogTWFjcm9zIHdp
dGggbXVsdGlwbGUgc3RhdGVtZW50cyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gYSBkbyAtIHdoaWxl
IGxvb3AKIzI5NzM6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDoxNTI6CisjZGVmaW5lIHFl
bXVfYXRvbWljX3JjdV9yZWFkX19ub2NoZWNrKHB0ciwgdmFscHRyKSAgICAgIFwKICAgICBfX2F0
b21pY19sb2FkKHB0ciwgdmFscHRyLCBfX0FUT01JQ19SRUxBWEVEKTsgICAgICAgXAogICAgIHNt
cF9yZWFkX2JhcnJpZXJfZGVwZW5kcygpOwoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0
aGF0ICcqJyAoY3R4OlZ4QikKIzMxMjg6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozNDc6
CisjZGVmaW5lIHFlbXVfYXRvbWljX3JlYWRfX25vY2hlY2socCkgKCooX190eXBlb2ZfXygqKHAp
KSB2b2xhdGlsZSopIChwKSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IFVzZSBvZiB2b2xhdGlsZSBpcyB1
c3VhbGx5IHdyb25nLCBwbGVhc2UgYWRkIGEgY29tbWVudAojMzEyODogRklMRTogaW5jbHVkZS9x
ZW11L2F0b21pYy5oOjM0NzoKKyNkZWZpbmUgcWVtdV9hdG9taWNfcmVhZF9fbm9jaGVjayhwKSAo
KihfX3R5cGVvZl9fKCoocCkpIHZvbGF0aWxlKikgKHApKQoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGJlZm9yZSB0aGF0ICcqJyAoY3R4OlZ4QikKIzMxMzA6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9t
aWMuaDozNDk6CisgICAgKCgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUqKSAocCkpID0gKGkp
KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IFVzZSBvZiB2b2xh
dGlsZSBpcyB1c3VhbGx5IHdyb25nLCBwbGVhc2UgYWRkIGEgY29tbWVudAojMzEzMDogRklMRTog
aW5jbHVkZS9xZW11L2F0b21pYy5oOjM0OToKKyAgICAoKCooX190eXBlb2ZfXygqKHApKSB2b2xh
dGlsZSopIChwKSkgPSAoaSkpCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcg
KGN0eDpWeFYpCiMzMTM1OiBGSUxFOiBpbmNsdWRlL3FlbXUvYXRvbWljLmg6MzUyOgorI2RlZmlu
ZSBxZW11X2F0b21pY19zZXQocHRyLCBpKSAgICAgcWVtdV9hdG9taWNfc2V0X19ub2NoZWNrKHB0
cixpKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCkVSUk9SOiBtZW1vcnkgYmFycmllciB3aXRob3V0IGNvbW1lbnQKIzMy
MTA6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDo0MTA6CisjZGVmaW5lIHFlbXVfYXRvbWlj
X3hjaGcocHRyLCBpKSAoc21wX21iKCksIF9fc3luY19sb2NrX3Rlc3RfYW5kX3NldChwdHIsIGkp
KQoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRl
IGxpbmUKIzMyODU6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDo0NjI6CisvKiBxZW11X2F0
b21pY19tYl9yZWFkL3NldCBzZW1hbnRpY3MgbWFwIEphdmEgdm9sYXRpbGUgdmFyaWFibGVzLiBU
aGV5IGFyZQoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNl
cGFyYXRlIGxpbmUKIzY0MDI6IEZJTEU6IHV0aWwvYml0bWFwLmM6MjE0OgorICAgICAgICAvKiBJ
ZiB3ZSBhdm9pZGVkIHRoZSBmdWxsIGJhcnJpZXIgaW4gcWVtdV9hdG9taWNfb3IoKSwgaXNzdWUg
YQoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRl
IGxpbmUKIzc0Mzg6IEZJTEU6IHV0aWwvcmN1LmM6ODU6CisgICAgICAgIC8qIEluc3RlYWQgb2Yg
dXNpbmcgcWVtdV9hdG9taWNfbWJfc2V0IGZvciBpbmRleC0+d2FpdGluZywgYW5kCgpXQVJOSU5H
OiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNzQ2
NDogRklMRTogdXRpbC9yY3UuYzoxNTQ6CisgICAgICAgIC8qIEluIGVpdGhlciBjYXNlLCB0aGUg
cWVtdV9hdG9taWNfbWJfc2V0IGJlbG93IGJsb2NrcyBzdG9yZXMgdGhhdCBmcmVlCgp0b3RhbDog
NyBlcnJvcnMsIDUgd2FybmluZ3MsIDY1MjAgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDFlNjQ1N2Rm
YjQ5OSAocWVtdS9hdG9taWMuaDogcHJlZml4IHFlbXVfIHRvIHNvbHZlIDxzdGRhdG9taWMuaD4g
Y29sbGlzaW9ucykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MjIwODU4MzguMjMwNTA1LTEt
c3RlZmFuaGFAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

