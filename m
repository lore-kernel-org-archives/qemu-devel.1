Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D15D207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D15D207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNPs-0007JZ-Cd
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNOk-0005xy-IG
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:00:34 -0400
Resent-Date: Wed, 20 May 2020 08:00:34 -0400
Resent-Message-Id: <E1jbNOk-0005xy-IG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNOi-0001Ir-Sl
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589976015; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hyL8JUMWPtr8Kc6yvGs9OA7Hcv0JyLj3FylpCvJfwjWkY27geXnldHPGOuruMGFta+YL5TUUnzCDID8J0RfS2fwkk4Yy50i+pcOdaWPsVXi17XUe7F1yJtVxl4d87aXou5TUfWydwLSJOi1LgU+pSb9KMsGPRpqHk4z57LRu4p4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589976015;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=F+vILczbSMRwLUeMyVJhuK/S+SPDpzya05n6quxD2yc=; 
 b=Tplf1HWI5WOIHRJTKeM7LT9R1HEPOYtCTR4k+bldDXefytKeCqZTuOIeCaJvvKq/bHeNmnI2TJuf4tMjcQzUzsEtW40KAsBAvpMR4ma7LB3go6UMkuPoYylFJtxBV3EwJSJ12Nw9m9adhzlj0BQhvI6ZfSrcgcZtTgFxi07TWH0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589976012848287.3321944349917;
 Wed, 20 May 2020 05:00:12 -0700 (PDT)
Message-ID: <158997601110.25482.12994184817450958176@45ef0f9c86ae>
In-Reply-To: <20200520093629.1495-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v7 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Wed, 20 May 2020 05:00:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 07:01:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDA5MzYyOS4xNDk1
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8tYmFsbG9vbi1wY2kubwogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8taW9tbXUtcGNpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2kzODYvcGMuYzogSW4gZnVuY3Rpb24gJ3BjX21hY2hpbmVfZG9uZSc6Ci90bXAvcWVtdS10ZXN0
L3NyYy9ody9pMzg2L3BjLmM6ODQ1OjMwOiBlcnJvcjogJ1BDTWFjaGluZVN0YXRlJyBoYXMgbm8g
bWVtYmVyIG5hbWVkICdmd19jZmcnCiAgICAgRldDZmdTdGF0ZSAqZndfY2ZnID0gcGNtcy0+Zndf
Y2ZnOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCm1ha2VbMV06ICoqKiBbaHcvaTM4
Ni9wYy5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5v
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLm8KLS0t
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL2ZzbC1pbXgzMS5vCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvaHcvYXJtL2t6bS5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcv
YXJtL2ZzbC1pbXg2Lm8KbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS9ody9hcm0vYXNwZWVkX3NvYy5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcv
YXJtL2FzcGVlZC5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0xYTZl
Yjc2MmFhMjQ0Njc5YjJkOGJiNWU5NGFiNzhjMicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWJiOXFnX3FoL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjAtMDcuNTcuMTguMTEyMDM6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTFhNmViNzYyYWEyNDQ2NzliMmQ4YmI1
ZTk0YWI3OGMyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJiOXFnX3FoL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAybTUzLjc5MHMKdXNlciAgICAwbTguNjY1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjAwOTM2MjkuMTQ5NS0xLW1pYW95dWJv
QGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

