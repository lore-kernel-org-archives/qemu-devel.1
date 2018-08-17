Received: from eggs.gnu.org ([2001:4830:134:3::10]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqcR8-0007G8-1P
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqcR4-00073g-Gj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:56:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fqcR4-00073Q-BW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:56:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1534419358-10932-8-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 16 Aug 2018 13:35:57 +0200")
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
	<1534419358-10932-8-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 17 Aug 2018 12:56:43 +0200
Message-ID: <87h8jtuuqc.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 7/8] tests/device-introspect: Test with
 all machines, not only with "none"
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
> Certain device introspection crashes used to only happen if you were
> using a certain machine, e.g. if the machine was using serial_hd() or
> nd_table[], and a device was trying to use these in its instance_init
> function, too.
>
> To be able to catch these problems, let's extend the device-introspect
> test to check the devices on all machine types, with and without the
> "-nodefaults" parameter (since this makes a difference sometimes, too).
> Since this is a rather slow operation, and most of the problems are
> already handled by testing with the "none" machine only, the test with
> all machines is only run in the "make check SPEED=slow" mode.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  tests/device-introspect-test.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
> index a38193b..a25092d 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -221,13 +221,13 @@ static void test_device_intro_abstract(void)
>      qtest_end();
>  }
>  
> -static void test_device_intro_concrete(void)
> +static void test_device_intro_concrete(const void *args)
                                          ^^^^^^^^^^^^^^^^

I hate this game of casts, but I have no good suggestions, sorry.
