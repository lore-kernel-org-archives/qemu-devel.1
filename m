Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE593C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85382053B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85382053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgXSa-0000Q8-Ui
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 13:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgXRs-0008Ad-FO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:45:08 -0400
Resent-Date: Wed, 03 Jun 2020 13:45:08 -0400
Resent-Message-Id: <E1jgXRs-0008Ad-FO@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgXRr-0005D2-15
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591206280; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mf/5XO/WCJa1vO5yYUsqcbuRELmvxawB3oAlsgo1GFDLn3WYnL0zvpSyIQPCaYppY18vdtgomHWZZZG6qyKqfuIbZorQY24lB4SJjXMTZPSjH5cS6oKmysEXHsfvxGCSiyhiBfp5Y/2CYZERrVrzzGJBb2tovPGUnci4DDhN/Zc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591206280;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aDOnCV6IQtXJX8qeg6Ku1tNLl+yTLwktKpyCW/ob1pM=; 
 b=mhR1GP5JJqctNZ2mdMFAeIgbG7IOWyxxVsAHd6Ax8xxJm/Xwy602ySHCplhJ4xCYv2fM3NirSJ4wv/oqoZDaHsbtgpdeNfW1/A6uacjxWN+XtdWQwufjtKCVsqm4z1H8I25LPgS4rvaardjeoHWKMxuSWmiuctnydlA23Xgcg4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591206278372849.3348416366575;
 Wed, 3 Jun 2020 10:44:38 -0700 (PDT)
Message-ID: <159120627656.23398.3742621530752770397@45ef0f9c86ae>
In-Reply-To: <20200603160442.3151170-1-anthony.perard@citrix.com>
Subject: Re: [PATCH v3] xen: fix build without pci passthrough
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: anthony.perard@citrix.com
Date: Wed, 3 Jun 2020 10:44:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 13:45:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: sstabellini@kernel.org, ehabkost@redhat.com, paul@xen.org, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.perard@citrix.com,
 xen-devel@lists.xenproject.org, rth@twiddle.net, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMzE2MDQ0Mi4zMTUx
MTcwLTEtYW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgaW8vY2hhbm5lbC1zb2NrZXQubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L3hlbi94ZW5fcHQuaDo0LAogICAgICAgICAgICAgICAgIGZyb20gL3RtcC9x
ZW11LXRlc3Qvc3JjL3N0dWJzL3hlbi1wdC5jOjk6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L2h3L3hlbi94ZW5fY29tbW9uLmg6MTM6MTA6IGZhdGFsIGVycm9yOiB4ZW5jdHJsLmg6IE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlIDx4ZW5jdHJsLmg+CiAgICAgICAgICBefn5+
fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0
L3NyYy9ydWxlcy5tYWs6Njk6IHN0dWJzL3hlbi1wdC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBpby9jaGFubmVsLXRscy5vCiAg
Q0MgICAgICBpby9jaGFubmVsLXdhdGNoLm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPWNkMDNlY2VhNGM0MzQ1Mjk4ODY0NTI5YzhiZDU2Y2MyJywgJy11JywgJzEwMDEn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1mbXkzbWYxei9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTAzLTEzLjQy
LjE5LjIyMDU5Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWNkMDNlY2VhNGM0
MzQ1Mjk4ODY0NTI5YzhiZDU2Y2MyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZt
eTNtZjF6L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJv
ciAyCgpyZWFsICAgIDJtMTcuODAzcwp1c2VyICAgIDBtOS4xMDRzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYwMzE2MDQ0Mi4zMTUx
MTcwLTEtYW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRv
cmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

