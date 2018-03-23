Received: from eggs.gnu.org ([2001:4830:134:3::10]:57554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUEu-0001mI-VX
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUEr-0007Jm-1M
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezUEq-0007Ic-Qs
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:28:40 -0400
Date: Fri, 23 Mar 2018 18:28:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323212837.GH28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520860275-101576-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/9] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Mar 12, 2018 at 02:11:11PM +0100, Igor Mammedov wrote:
> New option will be used to allow commands, which are prepared/need
> to run run in preconfig state. Other commands that should be able
> to run in preconfig state, should be ammeded to not expect machine
> in initialized state or deal with it.
> 
> For compatibility reasons, commands, that don't use new flag
> 'allowed-in-preconfig' explicitly, are not permited to run in
> preconfig state but allowed in all other states like they used
> to be.
> 
> Within this patch allow following commands in preconfig state:
>    qmp_capabilities
>    query-qmp-schema
>    query-commands
>    query-status
>    cont
> to allow qmp connection, basic introspection and moving to the next
> state.
> 
> PS:
> set-numa-node and query-hotpluggable-cpus will be enabled later in
> a separate patch.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

I didn't review the code yet, but:

Shouldn't this be applied before patch 3/9, for bisectability?
Otherwise it will be very easy to crash QEMU after applying patch
3/9.

-- 
Eduardo
