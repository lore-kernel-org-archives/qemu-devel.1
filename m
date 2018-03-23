Received: from eggs.gnu.org ([2001:4830:134:3::10]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTOl-00080n-6w
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTOi-0002mT-Kz
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezTOi-0002lz-F0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:34:48 -0400
Date: Fri, 23 Mar 2018 17:34:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323203444.GB28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520860275-101576-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] numa: postpone options
 post-processing till machine_run_board_init()
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

On Mon, Mar 12, 2018 at 02:11:07PM +0100, Igor Mammedov wrote:
> in preparation for numa options to being handled via QMP before
> machine_run_board_init(), move final numa configuration checks
> and processing to machine_run_board_init() so it could take into
> account both CLI (via parse_numa_opts()) and QMP input
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - remove duplicate qemu_opts_foreach() in numa_complete_configuration()
>     that was causing non explicitly IDed node "-numa node" parsed twice.

So, this moves initialization from parse_numa_opts() to
machine_run_board_init().

Let's see what can happen between those two functions:

Current code on main():

    parse_numa_opts(current_machine);

    machine_run_board_init(current_machine);

Wonderful.  :)

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
