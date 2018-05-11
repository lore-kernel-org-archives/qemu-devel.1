Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHBeR-000319-Jh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHBeN-00029j-1T
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fHBeM-00028d-Sl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F9BD402335F
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:16:10 +0000 (UTC)
References: <1525423069-61903-6-git-send-email-imammedo@redhat.com>
	<1526057503-39287-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b26f5f9-8133-996d-7e80-adb58c20a3b1@redhat.com>
Date: Fri, 11 May 2018 12:16:09 -0500
MIME-Version: 1.0
In-Reply-To: <1526057503-39287-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 05/11] qapi: introduce new cmd option
 "allow-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com

On 05/11/2018 11:51 AM, Igor Mammedov wrote:
> New option will be used to allow commands, which are prepared/need
> to run, during preconfig state. Other commands that should be able
> to run in preconfig state, should be amended to not expect machine
> in initialized state or deal with it.
> 
> For compatibility reasons, commands that don't use new flag
> 'allow-preconfig' explicitly are not permitted to run in
> preconfig state but allowed in all other states like they used
> to be.
> 
> Within this patch allow following commands in preconfig state:
>     qmp_capabilities
>     query-qmp-schema
>     query-commands
>     query-command-line-options
>     query-status
>     exit-preconfig
> to allow qmp connection, basic introspection and moving to the next
> state.
> 
> PS:
> set-numa-node and query-hotpluggable-cpus will be enabled later in
> a separate patches.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v8:
>    - (Eric Blake <eblake@redhat.com>)
>      * replace allowed-in-preconfig on allow-preconfig in commit msg
>      * more wording fixes
>      * make example in doc match QMP schema

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
