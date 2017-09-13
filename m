Received: from eggs.gnu.org ([2001:4830:134:3::10]:44968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Ud-0006kN-L4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Uc-0002g8-Rc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:53:55 -0400
Date: Wed, 13 Sep 2017 09:53:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913095341.6505861c.cohuck@redhat.com>
In-Reply-To: <20170912140149.7692-4-lvivier@redhat.com>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-4-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests/hmp: test "none" machine with
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On Tue, 12 Sep 2017 16:01:49 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> and add a test case of dump-guest-memory without
> "[begin length]" parameters.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/test-hmp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 729c0339f7..6b2dd5f8b8 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -35,6 +35,7 @@ static const char *hmp_cmds[] = {
>      "mouse_button 0",
>      "device_del mouse1",
>      "dump-guest-memory /dev/null 0 4096",
> +    "dump-guest-memory /dev/null",
>      "gdbserver",
>      "host_net_add user id=net0",
>      "hostfwd_add tcp::43210-:43210",
> @@ -159,5 +160,8 @@ int main(int argc, char **argv)
>  
>      qtest_cb_for_every_machine(add_machine_test_case);
>  
> +    /* as none machine has no memory, add a test case with memory */

s/no memory/no memory by default/

?

> +    qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);
> +
>      return g_test_run();
>  }

Regardless,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
