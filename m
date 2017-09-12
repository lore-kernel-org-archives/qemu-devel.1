Received: from eggs.gnu.org ([2001:4830:134:3::10]:41299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drk6I-000135-E0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drk6H-0002YS-Hk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:15:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-4-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bdb63706-f9b5-fcec-3508-1a0807e44f0a@amsat.org>
Date: Tue, 12 Sep 2017 09:15:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170911142056.15643-4-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 3/3] tests/hmp: test "none"
 machine with memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 09/11/2017 11:20 AM, Laurent Vivier wrote:
> and add a test case of dump-guest-memory without
> "[begin length]" parameters.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   tests/test-hmp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 729c0339f7..90693c0ce2 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -35,6 +35,7 @@ static const char *hmp_cmds[] = {
>       "mouse_button 0",
>       "device_del mouse1",
>       "dump-guest-memory /dev/null 0 4096",
> +    "dump-guest-memory /dev/null",
>       "gdbserver",
>       "host_net_add user id=net0",
>       "hostfwd_add tcp::43210-:43210",
> @@ -159,5 +160,9 @@ int main(int argc, char **argv)
>   
>       qtest_cb_for_every_machine(add_machine_test_case);
>   
> +    /* as none machine has no memory, add a test case with memory */
> +
> +    qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);

TIL:

"-m 0",
"none" machine is implemented in "null-machine.c",
"none" machine default maps memory at 0x0.

> +
>       return g_test_run();
>   }
> 
