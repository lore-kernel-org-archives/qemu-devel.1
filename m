Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9FC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D322520719
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guTTN/Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D322520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZFW-0006Iu-Mh
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7F-0003IV-36
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7C-00061t-Gk
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgus+I4PScrK5kZG79e46TuvQBI1kTB6qaRljTugNvI=;
 b=guTTN/Y2LTEWplwhbNhWfSM2WSwGeAss/5FCvfdLPMz26yknHFvlrXvkYXiPel1z0QFqTF
 Ihv9Pa+6Q9y7OJG8lWvwG/EtKUamI17wgqgg1cZwD8oDKRMYeBMpc+5iEDgu/o2WdWWKLv
 YtQTqhP37UBB45gmfU+uz8qP4aVt0qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-wFg8MZbMO3OYjtLxCRUBhA-1; Wed, 30 Sep 2020 06:13:35 -0400
X-MC-Unique: wFg8MZbMO3OYjtLxCRUBhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72741007467;
 Wed, 30 Sep 2020 10:13:33 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB4419D61;
 Wed, 30 Sep 2020 10:13:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 05/17] block/nvme: Use register definitions from 'block/nvme.h'
Date: Wed, 30 Sep 2020 11:12:53 +0100
Message-Id: <20200930101305.305302-6-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVXNlIHRo
ZSBOVk1lIHJlZ2lzdGVyIGRlZmluaXRpb25zIGZyb20gImJsb2NrL252bWUuaCIgd2hpY2gKZWFz
ZSBhIGJpdCByZXZpZXdpbmcgdGhlIGNvZGUgd2hpbGUgbWF0Y2hpbmcgdGhlIGRhdGFzaGVldC4K
ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpN
ZXNzYWdlLUlkOiA8MjAyMDA5MjIwODM4MjEuNTc4NTE5LTYtcGhpbG1kQHJlZGhhdC5jb20+Ci0t
LQogYmxvY2svbnZtZS5jIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2sv
bnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IGJkODI5OTBiNjYuLjk1OTU2OWQyNjIgMTAwNjQ0
Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9udm1lLmMKQEAgLTcxOCwyMiArNzE4LDIy
IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBjb25zdCBjaGFy
ICpkZXZpY2UsIGludCBuYW1lc3BhY2UsCiAgICAgICogSW5pdGlhbGl6YXRpb24iLiAqLwogCiAg
ICAgY2FwID0gbGU2NF90b19jcHUocmVncy0+Y2FwKTsKLSAgICBpZiAoIShjYXAgJiAoMVVMTCA8
PCAzNykpKSB7CisgICAgaWYgKCFOVk1FX0NBUF9DU1MoY2FwKSkgewogICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJEZXZpY2UgZG9lc24ndCBzdXBwb3J0IE5WTWUgY29tbWFuZCBzZXQiKTsKICAg
ICAgICAgcmV0ID0gLUVJTlZBTDsKICAgICAgICAgZ290byBvdXQ7CiAgICAgfQogCi0gICAgcy0+
cGFnZV9zaXplID0gTUFYKDQwOTYsIDEgPDwgKDEyICsgKChjYXAgPj4gNDgpICYgMHhGKSkpOwot
ICAgIHMtPmRvb3JiZWxsX3NjYWxlID0gKDQgPDwgKCgoY2FwID4+IDMyKSAmIDB4RikpKSAvIHNp
emVvZih1aW50MzJfdCk7CisgICAgcy0+cGFnZV9zaXplID0gTUFYKDQwOTYsIDEgPDwgTlZNRV9D
QVBfTVBTTUlOKGNhcCkpOworICAgIHMtPmRvb3JiZWxsX3NjYWxlID0gKDQgPDwgTlZNRV9DQVBf
RFNUUkQoY2FwKSkgLyBzaXplb2YodWludDMyX3QpOwogICAgIGJzLT5ibC5vcHRfbWVtX2FsaWdu
bWVudCA9IHMtPnBhZ2Vfc2l6ZTsKLSAgICB0aW1lb3V0X21zID0gTUlOKDUwMCAqICgoY2FwID4+
IDI0KSAmIDB4RkYpLCAzMDAwMCk7CisgICAgdGltZW91dF9tcyA9IE1JTig1MDAgKiBOVk1FX0NB
UF9UTyhjYXApLCAzMDAwMCk7CiAKICAgICAvKiBSZXNldCBkZXZpY2UgdG8gZ2V0IGEgY2xlYW4g
c3RhdGUuICovCiAgICAgcmVncy0+Y2MgPSBjcHVfdG9fbGUzMihsZTMyX3RvX2NwdShyZWdzLT5j
YykgJiAweEZFKTsKICAgICAvKiBXYWl0IGZvciBDU1RTLlJEWSA9IDAuICovCiAgICAgZGVhZGxp
bmUgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1FKSArIHRpbWVvdXRfbXMg
KiBTQ0FMRV9NUzsKLSAgICB3aGlsZSAobGUzMl90b19jcHUocmVncy0+Y3N0cykgJiAweDEpIHsK
KyAgICB3aGlsZSAoTlZNRV9DU1RTX1JEWShsZTMyX3RvX2NwdShyZWdzLT5jc3RzKSkpIHsKICAg
ICAgICAgaWYgKHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpID4gZGVhZGxp
bmUpIHsKICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlRpbWVvdXQgd2hpbGUgd2FpdGlu
ZyBmb3IgZGV2aWNlIHRvIHJlc2V0ICglIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQ
UklkNjQgIiBtcykiLApAQCAtNzYxLDE4ICs3NjEsMTkgQEAgc3RhdGljIGludCBudm1lX2luaXQo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5hbWVzcGFjZSwK
ICAgICB9CiAgICAgcy0+bnJfcXVldWVzID0gMTsKICAgICBRRU1VX0JVSUxEX0JVR19PTihOVk1F
X1FVRVVFX1NJWkUgJiAweEYwMDApOwotICAgIHJlZ3MtPmFxYSA9IGNwdV90b19sZTMyKChOVk1F
X1FVRVVFX1NJWkUgPDwgMTYpIHwgTlZNRV9RVUVVRV9TSVpFKTsKKyAgICByZWdzLT5hcWEgPSBj
cHVfdG9fbGUzMigoTlZNRV9RVUVVRV9TSVpFIDw8IEFRQV9BQ1FTX1NISUZUKSB8CisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKE5WTUVfUVVFVUVfU0laRSA8PCBBUUFfQVNRU19TSElGVCkp
OwogICAgIHJlZ3MtPmFzcSA9IGNwdV90b19sZTY0KHMtPnF1ZXVlc1tJTkRFWF9BRE1JTl0tPnNx
LmlvdmEpOwogICAgIHJlZ3MtPmFjcSA9IGNwdV90b19sZTY0KHMtPnF1ZXVlc1tJTkRFWF9BRE1J
Tl0tPmNxLmlvdmEpOwogCiAgICAgLyogQWZ0ZXIgc2V0dGluZyB1cCBhbGwgY29udHJvbCByZWdp
c3RlcnMgd2UgY2FuIGVuYWJsZSBkZXZpY2Ugbm93LiAqLwotICAgIHJlZ3MtPmNjID0gY3B1X3Rv
X2xlMzIoKGN0ejMyKE5WTUVfQ1FfRU5UUllfQllURVMpIDw8IDIwKSB8Ci0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoY3R6MzIoTlZNRV9TUV9FTlRSWV9CWVRFUykgPDwgMTYpIHwKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MSk7CisgICAgcmVncy0+Y2MgPSBjcHVfdG9f
bGUzMigoY3R6MzIoTlZNRV9DUV9FTlRSWV9CWVRFUykgPDwgQ0NfSU9DUUVTX1NISUZUKSB8Cisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAoY3R6MzIoTlZNRV9TUV9FTlRSWV9CWVRFUykgPDwg
Q0NfSU9TUUVTX1NISUZUKSB8CisgICAgICAgICAgICAgICAgICAgICAgICAgICBDQ19FTl9NQVNL
KTsKICAgICAvKiBXYWl0IGZvciBDU1RTLlJEWSA9IDEuICovCiAgICAgbm93ID0gcWVtdV9jbG9j
a19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSk7CiAgICAgZGVhZGxpbmUgPSBub3cgKyB0aW1l
b3V0X21zICogMTAwMDAwMDsKLSAgICB3aGlsZSAoIShsZTMyX3RvX2NwdShyZWdzLT5jc3RzKSAm
IDB4MSkpIHsKKyAgICB3aGlsZSAoIU5WTUVfQ1NUU19SRFkobGUzMl90b19jcHUocmVncy0+Y3N0
cykpKSB7CiAgICAgICAgIGlmIChxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1F
KSA+IGRlYWRsaW5lKSB7CiAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJUaW1lb3V0IHdo
aWxlIHdhaXRpbmcgZm9yIGRldmljZSB0byBzdGFydCAoJSIKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUFJJZDY0ICIgbXMpIiwKLS0gCjIuMjYuMgoK


