Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE10C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E4E22268
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E4E22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQoEw-0003SI-Bq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1kQoE4-0002u4-0Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:58:08 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:63950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1kQoE1-000851-CE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:58:07 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 6E88925DA98764217CC9;
 Fri,  9 Oct 2020 16:57:54 +0800 (CST)
Received: from kjyxapp01.zte.com.cn ([10.30.12.200])
 by mse-fl1.zte.com.cn with SMTP id 0998vjoF095383;
 Fri, 9 Oct 2020 16:57:45 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Fri, 9 Oct 2020 16:57:45 +0800 (CST)
Date: Fri, 9 Oct 2020 16:57:45 +0800 (CST)
X-Zmail-TransId: 2b055f8026097c95abd4
X-Mailer: Zmail v1.0
Message-ID: <202010091657451185963@zte.com.cn>
In-Reply-To: <20201004180443.2035359-22-f4bug@amsat.org>
References: 20201004180443.2035359-1-f4bug@amsat.org,
 20201004180443.2035359-22-f4bug@amsat.org
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
To: <f4bug@amsat.org>
Subject: =?UTF-8?B?UmU6W1JGQyBQQVRDSCAyMS8yMV0gY29udHJpYi9naXRkbTogQWRkIFpURSB0byB0aGUgZG9tYWluIG1hcA==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 0998vjoF095383
Received-SPF: pass client-ip=63.217.80.70; envelope-from=wang.yi59@zte.com.cn;
 helo=mxhk.zte.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 04:57:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: peng.hao2@zte.com.cn, wang.yong155@zte.com.cn, wang.liang82@zte.com.cn,
 wang.guang55@zte.com.cn, liu.yunh@zte.com.cn, li.ping288@zte.com.cn,
 liu.yi24@zte.com.cn, qemu-devel@nongnu.org, f4bug@amsat.org,
 xue.zhihong@zte.com.cn, jiang.biao2@zte.com.cn, lu.zhipeng@zte.com.cn,
 alex.bennee@linaro.org, wang.yechao255@zte.com.cn, liao.pingfang@zte.com.cn,
 fan.jiyun@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgUGhpbGlwcGUsCgo+IFRoZXJlIGlzIGEgbnVtYmVyIG9mIGNvbnRyaWJ1dG9ycyBmcm9tIHRo
aXMgZG9tYWluLAo+IGFkZCBpdHMgb3duIGVudHJ5IHRvIHRoZSBnaXRkbSBkb21haW4gbWFwLgo+
Cj4gQ2M6IEppYW5nIEJpYW8gPGppYW5nLmJpYW8yQHp0ZS5jb20uY24+Cj4gQ2M6IExpYW8gUGlu
Z2ZhbmcgPGxpYW8ucGluZ2ZhbmdAenRlLmNvbS5jbj4KPiBDYzogTGkgUGluZyA8bGkucGluZzI4
OEB6dGUuY29tLmNuPgo+IENjOiBQZW5nIEhhbyA8cGVuZy5oYW8yQHp0ZS5jb20uY24+Cj4gQ2M6
IFdhbmcgR3VhbmcgPHdhbmcuZ3Vhbmc1NUB6dGUuY29tLmNuPgo+IENjOiBXYW5nIFllY2hhbyA8
d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4KPiBDYzogV2FuZyBZb25nIDx3YW5nLnlvbmcxNTVA
enRlLmNvbS5jbj4KPiBDYzogWWkgV2FuZyA8d2FuZy55aTU5QHp0ZS5jb20uY24+Cj4gQ2M6IFl1
biBMaXUgPGxpdS55dW5oQHp0ZS5jb20uY24+Cj4gQ2M6IFpoaVBlbmcgTHUgPGx1LnpoaXBlbmdA
enRlLmNvbS5jbj4KPiBDYzogSml5dW4gRmFuIDxmYW4uaml5dW5AenRlLmNvbS5jbj4KPiBDYzog
TGl1IFlpIDxsaXUueWkyNEB6dGUuY29tLmNuPgo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+CgpUaGFua3MgZm9yIHRoZSBwYXRjaCwgaG93
ZXZlciwgdGhlc2UgcGVvcGxlIGhhdmUgbGVmdCBaVEU6CkppYW5nIEJpYW8sIExpIFBpbmcsIFBl
bmcgSGFvLCBXYW5nIEd1YW5nLCBXYW5nIFlvbmcsIFl1biBMaXUsClpoaVBlbmcgTHUuCgpSZXZp
ZXdlZC1ieTogWWkgV2FuZyA8d2FuZy55aTU5QHp0ZS5jb20uY24+Cgo+IC0tLQo+IE9uZSBSZXZp
ZXdlZC1ieS9BY2stYnkgZnJvbSBzb21lb25lIGZyb20gdGhpcyBkb21haW4KPiBzaG91bGQgYmUg
c3VmZmljaWVudCB0byBnZXQgdGhpcyBwYXRjaCBtZXJnZWQuCj4gLS0tCj4gIGNvbnRyaWIvZ2l0
ZG0vZG9tYWluLW1hcCB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+
IGRpZmYgLS1naXQgYS9jb250cmliL2dpdGRtL2RvbWFpbi1tYXAgYi9jb250cmliL2dpdGRtL2Rv
bWFpbi1tYXAKPiBpbmRleCA0ZTZiZjE2ZTRlLi44NzgxZTRiYTg3IDEwMDY0NAo+IC0tLSBhL2Nv
bnRyaWIvZ2l0ZG0vZG9tYWluLW1hcAo+ICsrKyBiL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1hcAo+
IEBAIC00MywzICs0Myw0IEBAIHdpbmRyaXZlci5jb20gICBXaW5kIFJpdmVyCj4gIHhpbGlueC5j
b20gICAgICBYaWxpbngKPiAgeWFkcm8uY29tICAgICAgIFlBRFJPCj4gIHlhbmRleC10ZWFtLnJ1
ICBZYW5kZXgKPiArenRlLmNvbS5jbiAgICAgIFpURQoKCi0tLQpCZXN0IHdpc2hlcwpZaSBXYW5n

--=====_003_next=====--

--=====_001_next=====--


