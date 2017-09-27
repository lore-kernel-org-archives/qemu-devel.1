Received: from eggs.gnu.org ([2001:4830:134:3::10]:48078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8CP-0004AC-P5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8CK-0003zU-Dy
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:00:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dx8CK-0003yx-9A
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:00:04 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170925112917.21340-5-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 25 Sep 2017 12:29:15 +0100")
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-5-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Sep 2017 11:00:02 +0200
Message-ID: <87shf8bjot.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/6] migration: wire vmstate_save_state
 errors up to vmstate_subsection_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Route the errors from vmstate_subsection_save up through
> vmstate_subsection_save (and back down, all rather recursive).
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
