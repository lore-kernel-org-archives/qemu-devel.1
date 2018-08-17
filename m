Received: from eggs.gnu.org ([2001:4830:134:3::10]:40452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc4c-0003KA-Cb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc4Y-0007GA-6f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:33:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fqc4Y-0007Fj-20
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:33:38 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1534419358-10932-6-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 16 Aug 2018 13:35:55 +0200")
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
	<1534419358-10932-6-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 17 Aug 2018 12:33:27 +0200
Message-ID: <87r2ixuvt4.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/8] tests: Skip old versioned machine
 types in quick testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> The tests that check something for all machine types currently spend
> a lot of time checking old machine types (like "pc-i440fx-2.0" for
> example). The chances that we find something new there in addition
> to checking the latest version of a machine type are pretty low, so
> we should not waste the time of the developers by testing this again
> and again in the "quick" testing mode.
> Thus let's add some code to determine whether we are testing a current
> machine type or an old one, and only test the old types if we are
> running in "SPEED=slow" mode.
> This decreases the testing time quite a bit now, e.g. the qom-test
> now finishes within 4 seconds for qemu-system-x86_64 instead of 30
> seconds when testing all machines.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks!!!!!
