Received: from eggs.gnu.org ([2001:4830:134:3::10]:55980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drQns-0002Hp-Id
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drQnr-0005Uq-Qg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:39:16 -0400
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-4-lvivier@redhat.com>
	<1299bf0c-f887-bcfe-2e97-3c7103d407a1@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ea5d741f-0a47-2000-93f8-aa78efcc5b9b@redhat.com>
Date: Mon, 11 Sep 2017 17:39:08 +0200
MIME-Version: 1.0
In-Reply-To: <1299bf0c-f887-bcfe-2e97-3c7103d407a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests/hmp: test "none" machine with
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On 11/09/2017 16:51, Thomas Huth wrote:
> On 11.09.2017 16:20, Laurent Vivier wrote:
>> and add a test case of dump-guest-memory without
>> "[begin length]" parameters.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  tests/test-hmp.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
>> index 729c0339f7..90693c0ce2 100644
>> --- a/tests/test-hmp.c
>> +++ b/tests/test-hmp.c
>> @@ -35,6 +35,7 @@ static const char *hmp_cmds[] = {
>>      "mouse_button 0",
>>      "device_del mouse1",
>>      "dump-guest-memory /dev/null 0 4096",
>> +    "dump-guest-memory /dev/null",
>>      "gdbserver",
>>      "host_net_add user id=net0",
>>      "hostfwd_add tcp::43210-:43210",
>> @@ -159,5 +160,9 @@ int main(int argc, char **argv)
>>  
>>      qtest_cb_for_every_machine(add_machine_test_case);
>>  
>> +    /* as none machine has no memory, add a test case with memory */
>> +
> 
> Maybe remove the empty line after the comment?

Bad habit. If I respin the series, I'll update this, otherwise I would
appreciate the committer does.

>> +    qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);
>> +
>>      return g_test_run();
>>  }
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Laurent
