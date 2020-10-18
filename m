Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5234DC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 14:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1472222B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 14:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="foTpGZTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1472222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU9pA-0006p4-Jq
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 10:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <380121850@163.com>) id 1kU9o3-0006Dr-2v
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 10:37:07 -0400
Received: from m13122.mail.163.com ([220.181.13.122]:58816)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <380121850@163.com>) id 1kU9nu-0002xD-BY
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=w0B/f
 iphX6H5GMBFKjkEVAQLPOwUTnwdISSY5etGrS8=; b=foTpGZTHAuigoRMTImAxl
 ByiLwn4QoiLG+zZajmIWWllprXgzDHTl6x7vTOxECw2ZEg7g7uvrr+KzEVLYeV+m
 29L4GyDzLUEkcOkm8hF6RwFWdIZDfbrN1NgMJJrVyaEtoTU90AIdNINwWT89KdNn
 sI52apuxEKtoqEc2BIBmEY=
Received: from 380121850$163.com ( [101.71.38.212] ) by
 ajax-webmail-wmsvr122 (Coremail) ; Sun, 18 Oct 2020 22:21:25 +0800 (CST)
X-Originating-IP: [101.71.38.212]
Date: Sun, 18 Oct 2020 22:21:25 +0800 (CST)
From: Lee <380121850@163.com>
To: qemu-devel@nongnu.org
Subject: ERROR: glib-2.48 gthread-2.0 is required to compile QEMU
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
Content-Type: multipart/alternative; 
 boundary="----=_Part_22188_1558093035.1603030885484"
MIME-Version: 1.0
Message-ID: <60400f23.1845.1753c16246c.Coremail.380121850@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: esGowAAXxSxlT4xfjpRsAA--.12890W
X-CM-SenderInfo: ityqijaryviqqrwthudrp/1tbiFgvBAF44NqWLjgACsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.122; envelope-from=380121850@163.com;
 helo=m13122.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 10:09:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_22188_1558093035.1603030885484
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CgpVYnVudHUgMTQuMDQuNiBMVFMsIFg4Nl82NApJICBtYWtlIHNvdXJjZSBjb2RlIG9mIHZlcnNp
b24gcWVtdSA1LjFcNS4wXDQuMixhbmQgZm91ZCB0aGUgZXJyb3I6Z2xpYi0yLjQ4IGd0aHJlYWQt
Mi4wIGlzIHJlcXVpcmVkIHRvIGNvbXBpbGUgUUVNVQp0cnkgYXB0LWdldCBpbnN0YWxsIGxpYmds
aWIyLjAtZGV2LGFuZCBpdCBpcyBzdWNlc3MgOgpSZWFkaW5nIHN0YXRlIGluZm9ybWF0aW9uLi4u
IERvbmUKbGliZ2xpYjIuMC1kZXYgaXMgYWxyZWFkeSB0aGUgbmV3ZXN0IHZlcnNpb24uCmJ1dCB0
aGUgZXJyb3IgaXMgIG5vdCBmaXg7IGFuZCBpIGZvdW5kIHRoYXQgdmVyc2lvbiBxZW11IDQuMSBp
cyBPSyx0aGUgc2FtZSBlbnZpcm9ubWVudKO7CmhpIGFsbCAsaXMgdGhlcmUgc29tZSBzdWdnZXN0
aW9uIGZvciBtZT8=
------=_Part_22188_1558093035.1603030885484
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYg
c3R5bGU9Im1hcmdpbjowOyI+VWJ1bnR1IDE0LjA0LjYgTFRTLCBYODZfNjQ8L2Rpdj48ZGl2IHN0
eWxlPSJtYXJnaW46MDsiPkkmbmJzcDsgbWFrZSBzb3VyY2UgY29kZSBvZiB2ZXJzaW9uIHFlbXUg
NS4xXDUuMFw0LjIsYW5kIGZvdWQgdGhlIDxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiBy
Z2IoMjIxLCA2NCwgNTApOyI+ZXJyb3I6Z2xpYi0yLjQ4IGd0aHJlYWQtMi4wIGlzIHJlcXVpcmVk
IHRvIGNvbXBpbGUgUUVNVTwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPnRyeSBh
cHQtZ2V0IGluc3RhbGwgbGliZ2xpYjIuMC1kZXYsYW5kIGl0IGlzIHN1Y2VzcyA6PC9kaXY+PGRp
diBzdHlsZT0ibWFyZ2luOjA7Ij48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6IDEwcHg7IGJhY2tncm91bmQtY29sb3I6IHJnYigxNDIsIDE3OCwgMjI5KTsiPlJl
YWRpbmcgc3RhdGUgaW5mb3JtYXRpb24uLi4gRG9uZTwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJt
YXJnaW46MDsiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHg7IGJhY2tncm91bmQtY29sb3I6
IHJnYigxNDIsIDE3OCwgMjI5KTsiPmxpYmdsaWIyLjAtZGV2IGlzIGFscmVhZHkgdGhlIG5ld2Vz
dCB2ZXJzaW9uLjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDE2cHg7Ij5idXQgdGhlIGVycm9yIGlzJm5ic3A7IG5vdCBmaXg7IGFuZCBp
IGZvdW5kIHRoYXQgdmVyc2lvbiBxZW11IDQuMSBpcyBPSyx0aGUgc2FtZSZuYnNwO2Vudmlyb25t
ZW50o7s8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxNnB4OyI+aGkgYWxsICxpcyB0aGVyZSBzb21lIHN1Z2dlc3Rpb24gZm9yIG1lPzwv
c3Bhbj48L2Rpdj48L2Rpdj48L2Rpdj4=
------=_Part_22188_1558093035.1603030885484--


