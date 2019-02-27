Received: from eggs.gnu.org ([209.51.188.92]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gz5pD-0002ek-1M
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 15:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gz5pC-0005S3-B1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 15:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gz5pC-0005Ge-2C
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 15:29:06 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190227164900.16378-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 27 Feb 2019 16:49:00 +0000")
References: <20190227164900.16378-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Feb 2019 21:32:11 +0100
Message-ID: <87pnrdrn04.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Cleanup during exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, alex.bennee@linaro.org

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Currently we cleanup the migration object as we exit main after the
> main_loop finishes; however if there's a migration running things
> get messy and we can end up with the migration thread still trying
> to access freed structures.
>
> We now take a ref to the object around the migration thread itself,
> so the act of dropping the ref during exit doesn't cause us to lose
> the state until the thread quits.
>
> Cancelling the migration during migration also tries to get the thread
> to quit.
>
> We do this a bit earlier; so hopefully migration gets out of the way
> before all the devices etc are freed.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>
