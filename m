Received: from eggs.gnu.org ([2001:4830:134:3::10]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1Cv8-0005q0-5H
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1Cv3-0001jq-7i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:23:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f1Cv3-0001jY-2V
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:23:21 -0400
Date: Wed, 28 Mar 2018 17:23:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180328172310.44fd682b@redhat.com>
In-Reply-To: <7ff0f691-b682-61e0-ebfe-f484c87fbc8d@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-6-git-send-email-imammedo@redhat.com>
	<7ff0f691-b682-61e0-ebfe-f484c87fbc8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, 23 Mar 2018 16:11:53 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/12/2018 08:11 AM, Igor Mammedov wrote:
[...]
> 
> > preconfig state but allowed in all other states like they used
> > to be.
> > 
> > Within this patch allow following commands in preconfig state:
> >     qmp_capabilities
> >     query-qmp-schema
> >     query-commands
> >     query-status
> >     cont
> > to allow qmp connection, basic introspection and moving to the next
> > state.  
> 
> Looks like a reasonable list.  Maybe also query-command-line-options 
> should be here?
added
 
> > 
> > PS:
> > set-numa-node and query-hotpluggable-cpus will be enabled later in
> > a separate patch.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v4:
> >    * replaces complex "universal" approach
> >       "[PATCH v3 5/9] QAPI: allow to specify valid runstates  per command"
> >      with a simpler new command flag "allowed-in-preconfig".
> >      (Eric Blake <eblake@redhat.com>)  
> 
> Thanks; it looks a lot more maintainable now.  However, you need to 
> rebase, now that 'allow-oob' has already landed.
rebased

[...]

All other comments are addressed as well
