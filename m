Received: from eggs.gnu.org ([2001:4830:134:3::10]:45253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9yi-0007It-T6
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9yf-0001dD-Ne
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:29:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fH9yf-0001d7-IL
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E6FE8182D05
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 15:29:01 +0000 (UTC)
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-7-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44a24950-bb9d-09a9-a8ae-31f0d9c96d77@redhat.com>
Date: Fri, 11 May 2018 10:29:00 -0500
MIME-Version: 1.0
In-Reply-To: <1525423069-61903-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 06/11] tests: qapi-schema tests for
 allow-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 05/04/2018 03:37 AM, Igor Mammedov wrote:
> use new allow-preconfig parameter in tests and make sure that
> the QAPISchema can parse allow-preconfig correctly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> v7:

Missing --- separator to stop 'git am' from including the changelog.

>    * s/allowed_in_preconfig/allow_preconfig/
>    * squash in "tests: add allow-preconfig-test for qapi-schema"
>    * reuse an-oob-command for allow-preconfig test and rename it to test-flags-command

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
