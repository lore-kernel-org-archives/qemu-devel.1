Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB58C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CD4207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CD4207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaaGw-0003E9-IM
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 03:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaaGQ-0002pF-6B
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:32:42 -0400
Resent-Date: Mon, 18 May 2020 03:32:42 -0400
Resent-Message-Id: <E1jaaGQ-0002pF-6B@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaaGO-0008CP-FB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589787132; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nGy3JOhQRVrlBAJl2Wa9PWpJfmzm9CuJiubZuqM/No6csrNN9LeSbZk+ieT3S5JfqokODEtyUgxrLp16nowg2qA9D+x5f0OhUGrbXvwN+o0qMyW9/WyQ0Gps5ExVRyddFDjZmlwMOSSJqYMhK1mtBv7wWQO2IaDSPvZ5QcgYcRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589787132;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zOE6y+7bTEvkdmIbwsBhb/bV4rTSVCBfvMJiN3XMce4=; 
 b=bYE0JrYH3q7aAontvxEx0BmPn+kCNYuOlJFSy0ak/s2uzeI3LZM72B0ohiUOMSduKBdmqDCpoOaozHq0q+r0KRqThbApp1GNMUYDWlse4VnpCCxYlEg5vULShg2D+vbcb5c+IUDFylVzXFe3F24l8BZ42dWYtHtAmaVO5vrbDic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589787129997803.2237119181268;
 Mon, 18 May 2020 00:32:09 -0700 (PDT)
Message-ID: <158978712688.15373.17385926106230983526@45ef0f9c86ae>
In-Reply-To: <1589782398-24406-1-git-send-email-kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v22 00/18] Add migration support for VFIO devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 18 May 2020 00:32:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 02:54:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5NzgyMzk4LTI0NDA2LTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1j
ZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcg
U0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIHg4Nl82NC1zb2Z0bW11L2h3L2lzYS9scGNfaWNoOS5vCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvaHcvdmlydGlvL3ZpcnRpby5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody92ZmlvL2NvbW1v
bi5jOiBJbiBmdW5jdGlvbiAndmZpb19saXN0ZXJuZXJfbG9nX3N5bmMnOgovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvdmZpby9jb21tb24uYzo5NzU6NTc6IGVycm9yOiAnZ2lvbW11JyBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFs
aXplZF0KICAgICAgICAgaW92YV9lbmQgPSBtZW1vcnlfcmVnaW9uX2lvbW11X2dldF9hZGRyZXNz
X2xpbWl0KGdpb21tdS0+aW9tbXUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody92ZmlvL2NvbW1v
bi5jOjk1MToyMTogbm90ZTogJ2dpb21tdScgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBWRklPR3Vl
c3RJT01NVSAqZ2lvbW11OwogICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbaHcvdmZpby9jb21tb24ub10g
RXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEND
ICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvbmV0L3ZpcnRpby1uZXQubwogIENDICAgICAgeDg2XzY0
LXNvZnRtbXUvaHcvcmRtYS9yZG1hX3V0aWxzLm8KLS0tCiAgQ0MgICAgICB4ODZfNjQtc29mdG1t
dS9ody92aXJ0aW8vdmhvc3QtdXNlci1mcy1wY2kubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUv
aHcvdmlydGlvL3ZpcnRpby1pb21tdS5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody92ZmlvL2NvbW1v
bi5jOiBJbiBmdW5jdGlvbiAndmZpb19saXN0ZXJuZXJfbG9nX3N5bmMnOgovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvdmZpby9jb21tb24uYzo5NzU6NTc6IGVycm9yOiAnZ2lvbW11JyBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFs
aXplZF0KICAgICAgICAgaW92YV9lbmQgPSBtZW1vcnlfcmVnaW9uX2lvbW11X2dldF9hZGRyZXNz
X2xpbWl0KGdpb21tdS0+aW9tbXUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody92ZmlvL2NvbW1v
bi5jOjk1MToyMTogbm90ZTogJ2dpb21tdScgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBWRklPR3Vl
c3RJT01NVSAqZ2lvbW11OwogICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbaHcvdmZpby9jb21tb24ub10g
RXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEND
ICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0LXZzb2NrLm8KbWFrZTogKioqIFth
YXJjaDY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTdiZGQzM2JhMDQ2YTQ5ZGU4ZTZkNGQw
YjFlYjBlZmVmJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWoxODM4N2U3L3NyYy9k
b2NrZXItc3JjLjIwMjAtMDUtMTgtMDMuMjguMTEuMTgwMDE6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPTdiZGQzM2JhMDQ2YTQ5ZGU4ZTZkNGQwYjFlYjBlZmVmCm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWoxODM4N2U3L3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTU2LjkyM3MKdXNlciAg
ICAwbTguNTMxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTU4OTc4MjM5OC0yNDQwNi0xLWdpdC1zZW5kLWVtYWlsLWt3YW5raGVkZUBudmlk
aWEuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

