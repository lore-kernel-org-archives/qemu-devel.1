Received: from eggs.gnu.org ([2001:4830:134:3::10]:42326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gAJis-0006rI-QD
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gAJin-0000QG-7R
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:00:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gAJim-0000OP-UI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:00:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AIwm9Y045055
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:00:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1pqqh7uq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:00:34 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 10 Oct 2018 13:00:33 -0600
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-27-armbru@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 10 Oct 2018 15:00:29 -0400
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-27-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <0678a06b-41f3-377c-d631-0f96b8b5d64f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 26/31] tpm: Clean up error reporting in
 tpm_init_tpmdev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

On 10/8/18 1:31 PM, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  tpm_init_tpmdev() does that, and then fails without
> setting an error.  Its caller main(), via tpm_init() and
> qemu_opts_foreach(), is fine with it, but clean it up anyway.
>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
