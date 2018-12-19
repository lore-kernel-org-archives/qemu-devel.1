Received: from eggs.gnu.org ([2001:4830:134:3::10]:38450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbau-0002nF-P3
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbar-0007cP-Eq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZbar-0007c8-7n
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:08:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
	<20181218112205.11727.18637.stgit@pasha-VirtualBox>
Date: Wed, 19 Dec 2018 14:08:48 +0100
In-Reply-To: <20181218112205.11727.18637.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Tue, 18 Dec 2018 14:22:05 +0300")
Message-ID: <87d0pxirz3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 12/20] replay: implement replay-seek
 command to proceed to the desired step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
> the execution to the specified step.
> The commands automatically loads nearest snapshot and replay the execution
> to find the desired step.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
[...]
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 0bcb547..9989706 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3179,6 +3179,22 @@
>  { 'command': 'replay-delete-break' }
>  
>  ##
> +# @replay-seek:
> +#
> +# Automatically proceeds to the specified step when replaying
> +# the execution.
> +#
> +# @step: destination execution step
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-seek", "data": { "step": 220414 } }
> +##
> +{ 'command': 'replay-seek', 'data': { 'step': 'int' } }
> +
> +##

Your commit message explains the relation to snapshots.  The QMP
documentation doesn't.

What happens when no snapshot preceding @step exists?

[...]
