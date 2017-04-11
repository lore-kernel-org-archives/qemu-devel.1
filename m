Received: from eggs.gnu.org ([2001:4830:134:3::10]:50359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxvfY-0000jv-QH
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxvfV-0006lS-M7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:17:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489765795-32398-1-git-send-email-craig@rancher.com>
Date: Tue, 11 Apr 2017 15:17:10 +0200
In-Reply-To: <1489765795-32398-1-git-send-email-craig@rancher.com> (Craig
	Jellick's message of "Fri, 17 Mar 2017 08:49:55 -0700")
Message-ID: <871ssz9j8p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Add 'none' as type for drive's if option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Jellick <craig@rancher.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Perhaps this can go via qemu-trivial.

Craig Jellick <craig@rancher.com> writes:

> Signed-off-by: Craig Jellick <craig@rancher.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 99af8ed..8291e64 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -591,7 +591,7 @@ Special files such as iSCSI devices can be specified using protocol
>  specific URLs. See the section for "Device URL Syntax" for more information.
>  @item if=@var{interface}
>  This option defines on which type on interface the drive is connected.
> -Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio.
> +Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
>  @item bus=@var{bus},unit=@var{unit}
>  These options define where is connected the drive by defining the bus number and
>  the unit id.
