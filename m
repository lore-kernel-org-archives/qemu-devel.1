Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B630E2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr3ajr+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B630E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSm1Q-0000V0-Ps
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iSm0a-000831-IK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iSm0Z-0002XU-4B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:55:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iSm0Z-0002Wz-0W
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573149345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lphH7JOrXmU0JJtedTi1ad3MctzpMaU3TaVoKshLhgk=;
 b=Vr3ajr+6vBLczf/mNNYe3CFmK+7I1iFy4oa5XPaYYzS54tjsJ7SX+1ImvFpeSDwjG23Jhx
 Dl+7JUDHYQvosOZBmRFv3P//05pdROYRzUZHNbowvvlI8N9KsBvJnSkhH8P/iplWR7JJfx
 SrMBAyTyiwczHunuZR2W20LusBxe8Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-UqjDvnQLNEWEZigs2jGKFw-1; Thu, 07 Nov 2019 12:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21E50800C61;
 Thu,  7 Nov 2019 17:55:41 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 359335DA82;
 Thu,  7 Nov 2019 17:55:06 +0000 (UTC)
Date: Thu, 7 Nov 2019 14:55:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 02/12] util/cutils: Add qemu_strtotime_ns()
Message-ID: <20191107175504.GU3812@habkost.net>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-3-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191107074511.14304-3-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UqjDvnQLNEWEZigs2jGKFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com, fan.du@intel.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 03:45:01PM +0800, Tao Xu wrote:
> To convert strings with time suffixes to numbers, support time unit are
> "ns" for nanosecond, "us" for microsecond, "ms" for millisecond or "s"
> for second. Add test for qemu_strtotime_ns, test the input of basic,
> time suffixes, float, invaild, trailing and overflow.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo


