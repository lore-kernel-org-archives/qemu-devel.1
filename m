Received: from eggs.gnu.org ([2001:4830:134:3::10]:33027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVxPY-0000Ui-NT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVxPT-0007FH-N1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:05:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVxPT-0007F1-HO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D66154022905
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 11:05:50 +0000 (UTC)
Date: Thu, 21 Jun 2018 12:05:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180621110544.GD2585@work-vm>
References: <20180620153947.30834-1-dgilbert@redhat.com>
	<20180620153947.30834-6-dgilbert@redhat.com>
	<20180621105608.01463ba5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621105608.01463ba5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/7] hmp: Add commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed, 20 Jun 2018 16:39:45 +0100
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Allow a bunch of the info commands to be used in preconfig.
> > 
> > version, chardev, name, uuid,memdev, iothreads
> >   Were enabled in QMP in the previous patch from Igor
> > 
> > status, hotpluggable_cpus
> >   Was enabled in the original allow-preconfig series
> > 
> > history
> >   is HMP specific
> > 
> > qom-tree, numa
> >   Don't have a QMP equivalent
> I'm not sure that 'info numa' in current state is useful/or valid
> at preconfig time wrt memory stats (depends on memory devices
> which hasn't created at that moment yet).
> Let's drop it for now from this series.

OK, gone.

> With it dropped:
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks.

Dave

> > Also enable the qom commands qom-list and qom-set.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hmp-commands-info.hx | 11 +++++++++++
> >  hmp-commands.hx      |  3 +++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index ddfcd5adcc..874ff07583 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -19,6 +19,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the version of QEMU",
> >          .cmd        = hmp_info_version,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -47,6 +48,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the character devices",
> >          .cmd        = hmp_info_chardev,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -165,6 +167,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the command line history",
> >          .cmd        = hmp_info_history,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -315,6 +318,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show NUMA information",
> >          .cmd        = hmp_info_numa,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -399,6 +403,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the current VM status (running|paused)",
> >          .cmd        = hmp_info_status,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -457,6 +462,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the current VM name",
> >          .cmd        = hmp_info_name,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -471,6 +477,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show the current VM UUID",
> >          .cmd        = hmp_info_uuid,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -613,6 +620,7 @@ ETEXI
> >          .params     = "[path]",
> >          .help       = "show QOM composition tree",
> >          .cmd        = hmp_info_qom_tree,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -671,6 +679,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show memory backends",
> >          .cmd        = hmp_info_memdev,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -699,6 +708,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "show iothreads",
> >          .cmd        = hmp_info_iothreads,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -829,6 +839,7 @@ ETEXI
> >          .params     = "",
> >          .help       = "Show information about hotpluggable CPUs",
> >          .cmd        = hmp_hotpluggable_cpus,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 3094294e5b..4bdf8e2090 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1828,6 +1828,7 @@ ETEXI
> >          .params     = "path",
> >          .help       = "list QOM properties",
> >          .cmd        = hmp_qom_list,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -1841,6 +1842,7 @@ ETEXI
> >          .params     = "path property value",
> >          .help       = "set QOM property",
> >          .cmd        = hmp_qom_set,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> > @@ -1855,6 +1857,7 @@ ETEXI
> >          .help       = "show various information about the system state",
> >          .cmd        = hmp_info_help,
> >          .sub_table  = info_cmds,
> > +        .flags      = "p",
> >      },
> >  
> >  STEXI
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
