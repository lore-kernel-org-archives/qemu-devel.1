Received: from eggs.gnu.org ([209.51.188.92]:42684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1grOC2-0001ad-42
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1grOBy-0007Ej-LP
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:28:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1grOBx-00071w-LE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:28:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x16EPuLm019538
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 09:28:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qfxsmaa83-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 09:28:19 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 6 Feb 2019 14:28:16 -0000
References: <1549456893-16589-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Feb 2019 15:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <1549456893-16589-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <332ccf49-9ae7-f35d-2bf1-6ced1315feb4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>



On 06.02.2019 13:41, Thomas Huth wrote:
> The license information in these files is rather confusing. The text
> declares LGPL first, but then says that contributions after 2012 are
> licensed under the GPL instead. How should the average user who just
> downloaded the release tarball know which part is now GPL and which
> is LGPL?
> 
> Looking at the text of the LGPL (see COPYING.LIB in the top directory),
> the license clearly states how this should be done instead:
> 
> "3. You may opt to apply the terms of the ordinary GNU General Public
>  License instead of this License to a given copy of the Library. To do
>  this, you must alter all the notices that refer to this License, so
>  that they refer to the ordinary GNU General Public License, version 2,
>  instead of to this License."
> 
> Thus let's clean up the confusing statements and use the proper GPL
> text only.

For the IBM-provided parts GPLv2+ is fine.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  linux-user/s390x/target_cpu.h | 19 ++++++++-----------
>  target/s390x/cpu.c            | 19 ++++++++-----------
>  target/s390x/cpu.h            | 19 ++++++++-----------
>  target/s390x/kvm.c            | 19 ++++++++-----------
>  4 files changed, 32 insertions(+), 44 deletions(-)
> 
> diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
> index 66ef8aa..aa181ce 100644
> --- a/linux-user/s390x/target_cpu.h
> +++ b/linux-user/s390x/target_cpu.h
> @@ -3,21 +3,18 @@
>   *
>   * Copyright (c) 2009 Ulrich Hecht
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * Contributions after 2012-10-29 are licensed under the terms of the
> - * GNU GPL, version 2 or (at your option) any later version.
> - *
> - * You should have received a copy of the GNU (Lesser) General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #ifndef S390X_TARGET_CPU_H
>  #define S390X_TARGET_CPU_H
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 18ba7f8..698dd9c 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -6,21 +6,18 @@
>   * Copyright (c) 2012 SUSE LINUX Products GmbH
>   * Copyright (c) 2012 IBM Corp.
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see
> - * <http://www.gnu.org/licenses/lgpl-2.1.html>
> - * Contributions after 2012-12-11 are licensed under the terms of the
> - * GNU GPL, version 2 or (at your option) any later version.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 47d2c2e..b71ac51 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -4,21 +4,18 @@
>   *  Copyright (c) 2009 Ulrich Hecht
>   *  Copyright IBM Corp. 2012, 2018
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * Contributions after 2012-10-29 are licensed under the terms of the
> - * GNU GPL, version 2 or (at your option) any later version.
> - *
> - * You should have received a copy of the GNU (Lesser) General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #ifndef S390X_CPU_H
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8613e19..9ff80c8 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -4,21 +4,18 @@
>   * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
>   * Copyright IBM Corp. 2012
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * Contributions after 2012-10-29 are licensed under the terms of the
> - * GNU GPL, version 2 or (at your option) any later version.
> - *
> - * You should have received a copy of the GNU (Lesser) General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "qemu/osdep.h"
> 
