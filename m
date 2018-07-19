Received: from eggs.gnu.org ([2001:4830:134:3::10]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgBqT-0005Wk-Ri
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgBqO-0000Wg-Ve
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:32:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgBqO-0000WX-Qa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:31:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
Date: Thu, 19 Jul 2018 18:31:54 +0200
In-Reply-To: <1532012617-16777-1-git-send-email-walling@linux.ibm.com> (Collin
	Walling's message of "Thu, 19 Jul 2018 11:03:37 -0400")
Message-ID: <87sh4f191h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>

You neglected to cc: maintainers.  Cc'ing them increases the odds your
patch will be noticed and picked up.  You can use
scripts/get_maintainer.pl to find maintainers.  You don't have to do
anything for this patch; it got noticed anyway.

David, this is yours :)

Collin Walling <walling@linux.ibm.com> writes:

> When typing 'help' followed by an unknown command, QEMU will
> not print anything to the command line to let the user know
> they typed a bad command. Let's fix this by printing a message
> to the monitor when this happens. For example:
>
>     (qemu) help xyz
>     unknown command: 'xyz'
>
> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/monitor.c b/monitor.c
> index 7af1f18..7942f9f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>              } else {
>                  help_cmd_dump_one(mon, cmd, args, arg_index);
>              }
> -            break;
> +            return;
>          }
>      }
> +
> +    /* Entry not found */
> +    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);
>  }
>  
>  static void help_cmd(Monitor *mon, const char *name)
