Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03336C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22F320707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq6mrlPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22F320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51649 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9qG-0004Df-0j
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iY9pM-00037s-OP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iY9pL-00017C-GB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:22:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iY9pL-00016p-Ah
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574432546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gpAFQcOXGgx6WEAd3cHVvL66T08MwbWCyUl7dmc9ls=;
 b=Iq6mrlPkJ/GbxdvgbgBIEdUU+w2mrOjOepb4cF9TmaH5vGAjh8X5ge2+fsXQ5TsmvODnFL
 rSJ48Vn0KWpWHOb1M8HbHhLShCb0UBdQEuWw8che4zB27UhDzL3dT0uUmTPLe7Otr021gM
 CdqtVlyPib+ZjRTAAO4gUyDwxip9kmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-oDPNNT6mMu2MnPV22jGNvA-1; Fri, 22 Nov 2019 09:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75192109D0AB;
 Fri, 22 Nov 2019 14:22:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABFA5D9E1;
 Fri, 22 Nov 2019 14:22:19 +0000 (UTC)
Message-ID: <d6ead0c3f9758b5def21dd690217bc9deeace2a9.camel@redhat.com>
Subject: Re: API definition for LUKS key management [V2]
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Fri, 22 Nov 2019 16:22:18 +0200
In-Reply-To: <20191112100253.GM2366658@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191112100253.GM2366658@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oDPNNT6mMu2MnPV22jGNvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, John Ferlan <jferlan@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This is the second version of the proposed QMP API for key management,
after discussion with Keven and Max.

Will this work?

Adding Peter Krempa to CC, to hear his opinion from the 
libvirt side.

Best regards,
	Maxim Levitsky


diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0cf68fea14..63b4cd2a27 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4725,6 +4725,69 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
 
+
+##
+# @BlockdevAmendOptionsQcow2:
+#
+# Options for amending the qcow2 image format
+# Currently only crypto related options can be amended
+#
+# @driver           block driver to create the image format
+#
+# Since: 5.0
+##
+{ 'struct': 'BlockdevAmendOptionsQcow2',
+  'data': {
+            '*encrypt': 'QCryptoBlockAmendOptions' } }
+
+##
+# @BlockdevAmendOptionsLUKS:
+#
+# Options for amending the luks image format
+#
+# @driver  block driver to create the image format
+#
+# Since: 5.0
+##
+{ 'struct': 'BlockdevAmendOptionsLUKS',
+  'base': 'QCryptoBlockAmendOptionsLUKS',
+  'data': {  }
+}
+
+##
+# @BlockdevAmendOptions:
+#
+# Options for amending blockdev configuration
+#
+# @driver   block driver that was used to create the block device
+#
+# Since: 5.0
+##
+{ 'union': 'BlockdevAmendOptions',
+  'base': {
+      'driver':         'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+      'luks':           'BlockdevAmendOptionsLUKS',
+      'qcow2':          'BlockdevAmendOptionsQcow2'
+  } }
+
+##
+# @x-blockdev-amend:
+#
+# Starts a job to create an image format on a given node. The job is
+# automatically finalized, but a manual job-dismiss is required.
+#
+# @job-id:          Identifier for the newly created job.
+#
+# @options:         Options for the image creation.
+#
+# Since: 5.0
+##
+{ 'command': 'x-blockdev-amend',
+  'data': { 'job-id': 'str',
+            'options': 'BlockdevAmendOptions' } }
+
 ##
 # @blockdev-open-tray:
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683..019db682cd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -309,3 +309,56 @@
   'base': 'QCryptoBlockInfoBase',
   'discriminator': 'format',
   'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
+
+
+##
+# @LUKSKeyslotUpdate:
+#
+# @keyslot:         If specified, will update only keyslot with this index
+#
+# @old-secret:      If specified, will only update keyslots that
+#                   can be opened with password which is contained in
+#                   QCryptoSecret with @old-secret ID
+#
+#                   If neither @keyslot nor @old-secret is specified,
+#                   first empty keyslot is selected for the update
+#
+# @new-secret:      The ID of a QCryptoSecret object providing a new decryption
+#                   key to place in all matching keyslots. Empty string erases the
+#                   keyslot.
+# @iter-time:       number of milliseconds to spend in
+#                   PBKDF passphrase processing
+##
+{ 'struct': 'LUKSKeyslotUpdate',
+  'data': {
+         '*keyslot': 'int',
+         '*old-secret': 'str',
+         'new-secret' : 'str',
+         '*iter-time' : 'int' } }
+
+
+##
+# @QCryptoBlockAmendOptionsLUKS:
+#
+# The options that can be changed on existing luks encrypted device
+# @keys: list of keyslot updates to perform (updates are performed in order)
+#
+# Since: 5.0
+##
+{ 'struct': 'QCryptoBlockAmendOptionsLUKS',
+  'data' : { 'keys': ['LUKSKeyslotUpdate'] } }
+
+
+##
+# @QCryptoBlockAmendOptions:
+#
+# The options that are available for all encryption formats
+# when initializing a new volume
+#
+# Since: 5.0
+##
+{ 'union': 'QCryptoBlockAmendOptions',
+  'base': 'QCryptoBlockOptionsBase',
+  'discriminator': 'format',
+  'data': {
+            'luks': 'QCryptoBlockAmendOptionsLUKS' } }


