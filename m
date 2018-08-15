Received: from eggs.gnu.org ([2001:4830:134:3::10]:47589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fq0Gb-00086s-US
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fq0GW-0006A4-SM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:11:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fq0GW-00067z-2k
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:11:28 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so3123061ita.5
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 11:11:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815133747.25032-12-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-12-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Aug 2018 20:11:22 +0200
Message-ID: <CAMxuvayJAG9GOfhQMYEerOBcq5tGG=GNtyS+LBNCzGJzkGjT0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 11/13] tests: remove "0.15" prefix for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 15, 2018 at 3:37 PM, Peter Xu <peterx@redhat.com> wrote:
> The "0.15" prefix seems useless.  Remove them.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I sent a similar patch long ago, and it is finally queued by Markus!
:) "tests: change /0.15/* tests to /qmp/*"

> ---
>  tests/test-qmp-cmds.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index ba41a6161e..989819b26d 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -286,11 +286,11 @@ int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>
> -    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
> -    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_failure);
> -    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
> -    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
> -    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
> +    g_test_add_func("/dispatch_cmd", test_dispatch_cmd);
> +    g_test_add_func("/dispatch_cmd_failure", test_dispatch_cmd_failure);
> +    g_test_add_func("/dispatch_cmd_io", test_dispatch_cmd_io);
> +    g_test_add_func("/dealloc_types", test_dealloc_types);
> +    g_test_add_func("/dealloc_partial", test_dealloc_partial);
>
>      test_qmp_init_marshal(&qmp_commands);
>      g_test_run();
> --
> 2.17.1
>
