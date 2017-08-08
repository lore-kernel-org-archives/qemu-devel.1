Received: from eggs.gnu.org ([2001:4830:134:3::10]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df6Ml-0006HO-4u
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df6Mj-0003XN-W4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:24:19 -0400
Date: Tue, 8 Aug 2017 16:23:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808152355.GM2081@work-vm>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-12-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502117160-24655-12-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/56] monitor: Drop unused HMP
 .args_type 'M'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> The previous commit switched balloon from 'M' to 'o', rendering 'M'
> unused.  It was never used for anything else.  Drop it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 8b54ba1..3b2757e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -101,8 +101,6 @@
>   * TYPEs that put an int64_t value with key NAME:
>   * 'l'    Argument is an expression (QEMU pocket calculator).
>   * 'i'    Like 'l' except value must fit into 32 bit unsigned.
> - * 'M'    Like 'l' except value must not be negative and is multiplied
> - *        by 2^20 (think "mebibyte").
>   *
>   * TYPEs that put an uint64_t value with key NAME:
>   * 'o'    Argument is a size (think "octets").  Without suffix the
> @@ -134,7 +132,7 @@
>   * '?'    Argument is optional, nothing is put when it is absent
>   *        (all types except 'O', '/', 'b').
>   * '.'    Argument is optional, must be preceded by '.' if present
> - *        (only types 'i', 'l', 'M')
> + *        (only types 'i', 'l')
>   */
>  
>  typedef struct mon_cmd_t {
> @@ -2913,7 +2911,6 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>              break;
>          case 'i':
>          case 'l':
> -        case 'M':
>              {
>                  int64_t val;
>  
> @@ -2944,12 +2941,6 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      monitor_printf(mon, "\'%s\' has failed: ", cmd->name);
>                      monitor_printf(mon, "integer is for 32-bit values\n");
>                      goto fail;
> -                } else if (c == 'M') {
> -                    if (val < 0) {
> -                        monitor_printf(mon, "enter a positive value\n");
> -                        goto fail;
> -                    }
> -                    val <<= 20;
>                  }
>                  qdict_put_int(qdict, key, val);
>              }
> -- 
> 2.7.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
