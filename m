Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVDFt-00089j-UR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVDFq-0005hp-QV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVDFq-0005hH-Jd
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 390377D0C2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:44:17 +0000 (UTC)
Date: Wed, 12 Jul 2017 16:44:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170712084412.GD7449@lemon>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170710072027.7948-5-famz@redhat.com>
	<20170711134829.GV17792@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711134829.GV17792@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] Introduce iothread-group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On Tue, 07/11 14:48, Stefan Hajnoczi wrote:
> > +    for (i = 0; i < group->size; ++i) {
> 
> group->size > INT_MAX must be rejected.  The error message below is
> wrong for this property:
> 
>   if (value < 0) {
>     error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
>                info->name, INT64_MAX);

Yes, I can add a PropInfo.max field so "size" can have a different max.

Fam
