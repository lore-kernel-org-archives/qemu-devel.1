Received: from eggs.gnu.org ([2001:4830:134:3::10]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cP8Ra-0007W1-Pv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cP8Ra-0000tJ-5U
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:51:02 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cP8Ra-0000t9-0y
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:51:02 -0500
Received: by mail-it0-x231.google.com with SMTP id 192so6466732itl.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 05:51:01 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <3de5e377-b08e-d286-219f-36e4208bdfdc@redhat.com>
References: <cover.1482164622.git.vpalatin@chromium.org>
	<bc2fa770d55e472477bcd5fef1524a2c5314d7f0.1482164622.git.vpalatin@chromium.org>
	<3de5e377-b08e-d286-219f-36e4208bdfdc@redhat.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Thu, 5 Jan 2017 14:50:40 +0100
Message-ID: <CAP_ceTyUd2a1kQdO2Ua5jUrBZS0oqYADmD8=uZ4VQLSjc89RuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 4/4] hax: add Darwin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Thu, Dec 22, 2016 at 10:49 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 19/12/2016 17:24, Vincent Palatin wrote:
>> diff --git a/cpus.c b/cpus.c
>> index 0e01791..b8db313 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1264,6 +1264,11 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>>          return;
>>      }
>>      cpu->thread_kicked = true;
>> +#ifdef CONFIG_DARWIN
>> +    if (hax_enabled()) {
>> +        cpu->exit_request = 1;
>> +    }
>> +#endif
>>      err = pthread_kill(cpu->thread->thread, SIG_IPI);
>>      if (err) {
>>          fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
>
> Instead of this, please place the "if" in qemu_cpu_kick before the call
> to qemu_cpu_kick_thread.  This way, it will be common to Win32 and Darwin.

Done in v6
