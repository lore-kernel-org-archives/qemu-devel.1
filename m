Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43800C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91ED20731
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf/jMHQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91ED20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlC6-0005JV-L0
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlAM-00034y-7L
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlAK-0004qz-GI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600077171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ01YYbUJbcDV2BxvGgf1AG/PxR81I3fMZ3BK2juzuM=;
 b=Qf/jMHQtUFES2a/2BSVct89p/FXcr7FLvUShVKclfTLFB2K+Y6QC9Fpk+jHJQgG7Z9LFkD
 4LK+ZXgRbB3WrexO/jA9H1mHKXJtIWJR0CMpvNHDNYdhDcrl2vissKfAvuin0JlvP60/TP
 LCuWpcAohGoubxI0O+SOT592C/+Mrf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Om0RFQ4AOqqX84Mv8hIgUA-1; Mon, 14 Sep 2020 05:52:50 -0400
X-MC-Unique: Om0RFQ4AOqqX84Mv8hIgUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDDA38015C5;
 Mon, 14 Sep 2020 09:52:48 +0000 (UTC)
Received: from localhost (ovpn-114-157.ams2.redhat.com [10.36.114.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7477819C4F;
 Mon, 14 Sep 2020 09:52:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] configure: rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI
Date: Mon, 14 Sep 2020 10:52:31 +0100
Message-Id: <20200914095231.621068-4-stefanha@redhat.com>
In-Reply-To: <20200914095231.621068-1-stefanha@redhat.com>
References: <20200914095231.621068-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIFFFTVVfR0FfTVNJX0VOQUJMRUQgY29uZmlnLWhvc3QubWFrIHZhcmlhYmxlIGlzIGVtaXR0
ZWQgYnkKLi9jb25maWd1cmUuIG1lc29uLmJ1aWxkIGFjdHVhbGx5IGNoZWNrcyBmb3IgQ09ORklH
X1FHQV9NU0lfRU5BQkxFRDoKCiAgc3VtbWFyeV9pbmZvICs9IHsnUUdBIE1TSSBzdXBwb3J0Jzog
ICBjb25maWdfaG9zdC5oYXNfa2V5KCdDT05GSUdfUUdBX01TSV9FTkFCTEVEJyl9CgpSZW5hbWUg
UUVNVV9HQV9NU0lfRU5BQkxFRCB0byBDT05GSUdfUUdBX01TSSBmb3IgY29uc2lzdGVuY3kgd2l0
aApDT05GSUdfUUdBX1ZTUy4gQWxzbyB1c2UgJ3knIGluc3RlYWQgb2YgJ3llcycgZm9yIGNvbnNp
c3RlbmN5LgoKVGhpcyBmaXhlcyB0aGUgZmVhdHVyZSBzdW1tYXJ5IHByaW50ZWQgYnkgbWVzb24u
YnVpbGQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5j
b20+Ci0tLQogY29uZmlndXJlICAgfCAyICstCiBNYWtlZmlsZSAgICB8IDIgKy0KIG1lc29uLmJ1
aWxkIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29uZmlndXJlCmluZGV4IGE5MTc0NTY5MDku
LmZkMTIwZDU0ZmIgMTAwNzU1Ci0tLSBhL2NvbmZpZ3VyZQorKysgYi9jb25maWd1cmUKQEAgLTY1
NjksNyArNjU2OSw3IEBAIGlmIHRlc3QgIiRtaW5ndzMyIiA9ICJ5ZXMiIDsgdGhlbgogICAgIGVj
aG8gIkNPTkZJR19RR0FfTlRERFNDU0k9eSIgPj4gJGNvbmZpZ19ob3N0X21hawogICBmaQogICBp
ZiB0ZXN0ICIkZ3Vlc3RfYWdlbnRfbXNpIiA9ICJ5ZXMiOyB0aGVuCi0gICAgZWNobyAiUUVNVV9H
QV9NU0lfRU5BQkxFRD15ZXMiID4+ICRjb25maWdfaG9zdF9tYWsKKyAgICBlY2hvICJDT05GSUdf
UUdBX01TST15IiA+PiAkY29uZmlnX2hvc3RfbWFrCiAgICAgZWNobyAiUUVNVV9HQV9NU0lfTUlO
R1dfRExMX1BBVEg9JHtRRU1VX0dBX01TSV9NSU5HV19ETExfUEFUSH0iID4+ICRjb25maWdfaG9z
dF9tYWsKICAgICBlY2hvICJRRU1VX0dBX01TSV9XSVRIX1ZTUz0ke1FFTVVfR0FfTVNJX1dJVEhf
VlNTfSIgPj4gJGNvbmZpZ19ob3N0X21hawogICAgIGVjaG8gIlFFTVVfR0FfTVNJX0FSQ0g9JHtR
RU1VX0dBX01TSV9BUkNIfSIgPj4gJGNvbmZpZ19ob3N0X21hawpkaWZmIC0tZ2l0IGEvTWFrZWZp
bGUgYi9NYWtlZmlsZQppbmRleCA1N2Y3MmY1NmM2Li44M2YxMTI0Y2JmIDEwMDY0NAotLS0gYS9N
YWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMjg2LDcgKzI4Niw3IEBAIGVuZGlmCiBpZmRlZiBD
T05GSUdfV0lOMzIKIAlAZWNobyAgJ1dpbmRvd3MgdGFyZ2V0czonCiAJJChjYWxsIHByaW50LWhl
bHAsaW5zdGFsbGVyLEJ1aWxkIE5TSVMtYmFzZWQgaW5zdGFsbGVyIGZvciBRRU1VKQotaWZkZWYg
UUVNVV9HQV9NU0lfRU5BQkxFRAoraWZkZWYgQ09ORklHX1FHQV9NU0kKIAkkKGNhbGwgcHJpbnQt
aGVscCxtc2ksQnVpbGQgTVNJLWJhc2VkIGluc3RhbGxlciBmb3IgcWVtdS1nYSkKIGVuZGlmCiAJ
QGVjaG8gICcnCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IDY5
MDcyM2I0NzAuLjA1N2Y2NDc2ZTYgMTAwNjQ0Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29u
LmJ1aWxkCkBAIC0xNDgzLDcgKzE0ODMsNyBAQCBpZiB0YXJnZXRvcyA9PSAnd2luZG93cycKICAg
ZW5kaWYKICAgc3VtbWFyeV9pbmZvICs9IHsnUUdBIFZTUyBzdXBwb3J0JzogICBjb25maWdfaG9z
dC5oYXNfa2V5KCdDT05GSUdfUUdBX1ZTUycpfQogICBzdW1tYXJ5X2luZm8gKz0geydRR0EgdzMy
IGRpc2sgaW5mbyc6IGNvbmZpZ19ob3N0Lmhhc19rZXkoJ0NPTkZJR19RR0FfTlRERFNDU0knKX0K
LSAgc3VtbWFyeV9pbmZvICs9IHsnUUdBIE1TSSBzdXBwb3J0JzogICBjb25maWdfaG9zdC5oYXNf
a2V5KCdDT05GSUdfUUdBX01TSV9FTkFCTEVEJyl9CisgIHN1bW1hcnlfaW5mbyArPSB7J1FHQSBN
U0kgc3VwcG9ydCc6ICAgY29uZmlnX2hvc3QuaGFzX2tleSgnQ09ORklHX1FHQV9NU0knKX0KIGVu
ZGlmCiBzdW1tYXJ5X2luZm8gKz0geydzZWNjb21wIHN1cHBvcnQnOiAgIGNvbmZpZ19ob3N0Lmhh
c19rZXkoJ0NPTkZJR19TRUNDT01QJyl9CiBzdW1tYXJ5X2luZm8gKz0geydjb3JvdXRpbmUgYmFj
a2VuZCc6IGNvbmZpZ19ob3N0WydDT05GSUdfQ09ST1VUSU5FX0JBQ0tFTkQnXX0KLS0gCjIuMjYu
MgoK


