Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C401205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfEgKufe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C401205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6x5-0005yF-ET
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pF-00056U-Vz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pE-0001cA-CW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTntwih9GmipO+si162ywTzSXmoovsyQaYqvMXpd3UE=;
 b=JfEgKufeekvZen1Lhwd0nRbyKP87g1wsNPOk74E/KWWOzYkrn894TEQ+MY1iIHZDj7IuCc
 lEgv9DG58kWyN1o/tMm5f4n8hC8STPPm2cHuntrYETD3P3rY2xOKiKONwp/b35XGGTG8mZ
 XP4hsQ7gEgGLMugShvsdo+zpcGN8+Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-kzByuLuaMt2leZftNbQlrA-1; Thu, 14 May 2020 01:54:24 -0400
X-MC-Unique: kzByuLuaMt2leZftNbQlrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1848014D7;
 Thu, 14 May 2020 05:54:22 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69B6A6A977;
 Thu, 14 May 2020 05:54:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 09/32] python/qemu: add pylint to Pipfile
Date: Thu, 14 May 2020 01:53:40 -0400
Message-Id: <20200514055403.18902-10-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bug in pylint 2.5.1 and 2.5.2 causes false positives for
relative imports. This version is pinned at 2.5.0 until a fix is
available.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile      |   1 +
 python/Pipfile.lock | 123 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 python/Pipfile.lock

diff --git a/python/Pipfile b/python/Pipfile
index 9534830b5e..ddb2b5a518 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -4,6 +4,7 @@ url = "https://pypi.org/simple"
 verify_ssl = true
 
 [dev-packages]
+pylint = "==2.5.0"
 
 [packages]
 
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
new file mode 100644
index 0000000000..e6faa832e4
--- /dev/null
+++ b/python/Pipfile.lock
@@ -0,0 +1,123 @@
+{
+    "_meta": {
+        "hash": {
+            "sha256": "7815dedfd7481b645389153dd45e9adb82c72956d0efc74d8f087497624b75e4"
+        },
+        "pipfile-spec": 6,
+        "requires": {
+            "python_version": "3.6"
+        },
+        "sources": [
+            {
+                "name": "pypi",
+                "url": "https://pypi.org/simple",
+                "verify_ssl": true
+            }
+        ]
+    },
+    "default": {},
+    "develop": {
+        "astroid": {
+            "hashes": [
+                "sha256:4c17cea3e592c21b6e222f673868961bad77e1f985cb1694ed077475a89229c1",
+                "sha256:d8506842a3faf734b81599c8b98dcc423de863adcc1999248480b18bd31a0f38"
+            ],
+            "version": "==2.4.1"
+        },
+        "isort": {
+            "hashes": [
+                "sha256:54da7e92468955c4fceacd0c86bd0ec997b0e1ee80d97f67c35a78b719dccab1",
+                "sha256:6e811fcb295968434526407adb8796944f1988c5b65e8139058f2014cbe100fd"
+            ],
+            "version": "==4.3.21"
+        },
+        "lazy-object-proxy": {
+            "hashes": [
+                "sha256:0c4b206227a8097f05c4dbdd323c50edf81f15db3b8dc064d08c62d37e1a504d",
+                "sha256:194d092e6f246b906e8f70884e620e459fc54db3259e60cf69a4d66c3fda3449",
+                "sha256:1be7e4c9f96948003609aa6c974ae59830a6baecc5376c25c92d7d697e684c08",
+                "sha256:4677f594e474c91da97f489fea5b7daa17b5517190899cf213697e48d3902f5a",
+                "sha256:48dab84ebd4831077b150572aec802f303117c8cc5c871e182447281ebf3ac50",
+                "sha256:5541cada25cd173702dbd99f8e22434105456314462326f06dba3e180f203dfd",
+                "sha256:59f79fef100b09564bc2df42ea2d8d21a64fdcda64979c0fa3db7bdaabaf6239",
+                "sha256:8d859b89baf8ef7f8bc6b00aa20316483d67f0b1cbf422f5b4dc56701c8f2ffb",
+                "sha256:9254f4358b9b541e3441b007a0ea0764b9d056afdeafc1a5569eee1cc6c1b9ea",
+                "sha256:9651375199045a358eb6741df3e02a651e0330be090b3bc79f6d0de31a80ec3e",
+                "sha256:97bb5884f6f1cdce0099f86b907aa41c970c3c672ac8b9c8352789e103cf3156",
+                "sha256:9b15f3f4c0f35727d3a0fba4b770b3c4ebbb1fa907dbcc046a1d2799f3edd142",
+                "sha256:a2238e9d1bb71a56cd710611a1614d1194dc10a175c1e08d75e1a7bcc250d442",
+                "sha256:a6ae12d08c0bf9909ce12385803a543bfe99b95fe01e752536a60af2b7797c62",
+                "sha256:ca0a928a3ddbc5725be2dd1cf895ec0a254798915fb3a36af0964a0a4149e3db",
+                "sha256:cb2c7c57005a6804ab66f106ceb8482da55f5314b7fcb06551db1edae4ad1531",
+                "sha256:d74bb8693bf9cf75ac3b47a54d716bbb1a92648d5f781fc799347cfc95952383",
+                "sha256:d945239a5639b3ff35b70a88c5f2f491913eb94871780ebfabb2568bd58afc5a",
+                "sha256:eba7011090323c1dadf18b3b689845fd96a61ba0a1dfbd7f24b921398affc357",
+                "sha256:efa1909120ce98bbb3777e8b6f92237f5d5c8ea6758efea36a473e1d38f7d3e4",
+                "sha256:f3900e8a5de27447acbf900b4750b0ddfd7ec1ea7fbaf11dfa911141bc522af0"
+            ],
+            "version": "==1.4.3"
+        },
+        "mccabe": {
+            "hashes": [
+                "sha256:ab8a6258860da4b6677da4bd2fe5dc2c659cff31b3ee4f7f5d64e79735b80d42",
+                "sha256:dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"
+            ],
+            "version": "==0.6.1"
+        },
+        "pylint": {
+            "hashes": [
+                "sha256:588e114e3f9a1630428c35b7dd1c82c1c93e1b0e78ee312ae4724c5e1a1e0245",
+                "sha256:bd556ba95a4cf55a1fc0004c00cf4560b1e70598a54a74c6904d933c8f3bd5a8"
+            ],
+            "index": "pypi",
+            "version": "==2.5.0"
+        },
+        "six": {
+            "hashes": [
+                "sha256:236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a",
+                "sha256:8f3cd2e254d8f793e7f3d6d9df77b92252b52637291d0f0da013c76ea2724b6c"
+            ],
+            "version": "==1.14.0"
+        },
+        "toml": {
+            "hashes": [
+                "sha256:229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c",
+                "sha256:235682dd292d5899d361a811df37e04a8828a5b1da3115886b73cf81ebc9100e"
+            ],
+            "version": "==0.10.0"
+        },
+        "typed-ast": {
+            "hashes": [
+                "sha256:0666aa36131496aed8f7be0410ff974562ab7eeac11ef351def9ea6fa28f6355",
+                "sha256:0c2c07682d61a629b68433afb159376e24e5b2fd4641d35424e462169c0a7919",
+                "sha256:249862707802d40f7f29f6e1aad8d84b5aa9e44552d2cc17384b209f091276aa",
+                "sha256:24995c843eb0ad11a4527b026b4dde3da70e1f2d8806c99b7b4a7cf491612652",
+                "sha256:269151951236b0f9a6f04015a9004084a5ab0d5f19b57de779f908621e7d8b75",
+                "sha256:4083861b0aa07990b619bd7ddc365eb7fa4b817e99cf5f8d9cf21a42780f6e01",
+                "sha256:498b0f36cc7054c1fead3d7fc59d2150f4d5c6c56ba7fb150c013fbc683a8d2d",
+                "sha256:4e3e5da80ccbebfff202a67bf900d081906c358ccc3d5e3c8aea42fdfdfd51c1",
+                "sha256:6daac9731f172c2a22ade6ed0c00197ee7cc1221aa84cfdf9c31defeb059a907",
+                "sha256:715ff2f2df46121071622063fc7543d9b1fd19ebfc4f5c8895af64a77a8c852c",
+                "sha256:73d785a950fc82dd2a25897d525d003f6378d1cb23ab305578394694202a58c3",
+                "sha256:8c8aaad94455178e3187ab22c8b01a3837f8ee50e09cf31f1ba129eb293ec30b",
+                "sha256:8ce678dbaf790dbdb3eba24056d5364fb45944f33553dd5869b7580cdbb83614",
+                "sha256:aaee9905aee35ba5905cfb3c62f3e83b3bec7b39413f0a7f19be4e547ea01ebb",
+                "sha256:bcd3b13b56ea479b3650b82cabd6b5343a625b0ced5429e4ccad28a8973f301b",
+                "sha256:c9e348e02e4d2b4a8b2eedb48210430658df6951fa484e59de33ff773fbd4b41",
+                "sha256:d205b1b46085271b4e15f670058ce182bd1199e56b317bf2ec004b6a44f911f6",
+                "sha256:d43943ef777f9a1c42bf4e552ba23ac77a6351de620aa9acf64ad54933ad4d34",
+                "sha256:d5d33e9e7af3b34a40dc05f498939f0ebf187f07c385fd58d591c533ad8562fe",
+                "sha256:fc0fea399acb12edbf8a628ba8d2312f583bdbdb3335635db062fa98cf71fca4",
+                "sha256:fe460b922ec15dd205595c9b5b99e2f056fd98ae8f9f56b888e7a17dc2b757e7"
+            ],
+            "markers": "implementation_name == 'cpython' and python_version < '3.8'",
+            "version": "==1.4.1"
+        },
+        "wrapt": {
+            "hashes": [
+                "sha256:b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
+            ],
+            "version": "==1.12.1"
+        }
+    }
+}
-- 
2.21.1


