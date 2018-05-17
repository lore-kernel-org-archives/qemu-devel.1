Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJJCF-0002Mn-7i
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJJCC-0004vC-5f
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:43:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fJJCB-0004uk-VX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8588379D36
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:43:51 +0000 (UTC)
References: <7f80806c-3685-f679-c5af-1ca7a9b0052b@redhat.com>
	<1526556524-267991-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91d36963-7b28-d00c-21fe-a4ce8e4a1202@redhat.com>
Date: Thu, 17 May 2018 08:43:50 -0500
MIME-Version: 1.0
In-Reply-To: <1526556524-267991-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 08/11] tests: extend qmp test with
 preconfig checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

On 05/17/2018 06:28 AM, Igor Mammedov wrote:
> Add permission checks for commands at 'preconfig' stage.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v8:
>    * there isn't QDECREF anymore use qobject_unref instead
>    * add negative test for exit-preconfig

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
