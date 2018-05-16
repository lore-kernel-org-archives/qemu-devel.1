Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ18G-0000NP-QG
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ18B-00005s-T4
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ18B-0008St-NH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C10ED30CFF06
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:26:30 +0000 (UTC)
Date: Wed, 16 May 2018 15:26:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516182628.GJ4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-11-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525423069-61903-11-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 10/11] qmp: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com

On Fri, May 04, 2018 at 10:37:48AM +0200, Igor Mammedov wrote:
> Command is allowed to run only in preconfig stage and
> will allow to configure numa mapping for CPUs depending
> on possible CPUs layout (query-hotpluggable-cpus) for
> given machine instance.
> 
> Example of configuration session:
> $QEMU -smp 2 --preconfig ...
> 
> QMP:
> -> {'execute': 'query-hotpluggable-cpus' }
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 0}, ... }
>    ]}
> 
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 0 } }
> <- {'return': {}}
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',
>        'node-id': 0, 'core-id': 0, 'thread-id': 0, 'socket-id': 1, }
>    }
> <- {'return': {}}
> 
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 1 } }
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',
>        'node-id': 1, 'core-id': 0, 'thread-id': 0, 'socket-id': 0 }
>    }
> <- {'return': {}}
> 
> -> {'execute': 'query-hotpluggable-cpus' }
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 1, 'socket-id': 0}, ... }
>    ]}
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I suggest sending a test case as a follow-up patch.

-- 
Eduardo
