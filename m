Received: from eggs.gnu.org ([2001:4830:134:3::10]:60385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpAwB-0000D9-9Z
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpAwA-0001EG-Cx
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:23:03 -0400
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
	<20180813101453.10200-34-e.emanuelegiuseppe@gmail.com>
	<20180813141435-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <440dc610-b4cd-0db1-7dd1-4851ed86f31b@redhat.com>
Date: Mon, 13 Aug 2018 13:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180813141435-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 33/33] tests/qgraph: temporarly commented
 vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>

On 13/08/2018 13:15, Michael S. Tsirkin wrote:
> On Mon, Aug 13, 2018 at 12:14:53PM +0200, Emanuele Giuseppe Esposito wrote:
>> vhost-user-test has not converted to qgraph yet, and since
>> it uses virtio interface, it won't work, causing make check
>> to fail.
>> Commented out until it does not get converted to graph node.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> Two problems with that
> - we lose vhost user coverage
> - bisecting to before patch 33 will leave us with
>   a failing make check

See $SUBJECT, "temporarily". :)

Paolo

> 
>> ---
>>  tests/Makefile.include | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 15926cc95f..30355058fc 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -287,10 +287,10 @@ check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>>  gcov-files-i386-y += hw/pci-host/q35.c
>> -check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
>> -ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
>> -check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
>> -endif
>> +# check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
>> +# ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
>> +# check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
>> +# endif
>>  check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-swtpm-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-swtpm-test$(EXESUF)
>> -- 
>> 2.17.1
