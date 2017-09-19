Received: from eggs.gnu.org ([2001:4830:134:3::10]:32882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFBi-0008H3-LN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFBf-0005Wk-IZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFBf-0005Wa-FF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id c69so1913412qke.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:51:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918215719.16415-1-f4bug@amsat.org>
	<20170918225552.GM10621@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36b5e019-4f30-666b-7479-df8de0a6f936@amsat.org>
Date: Tue, 19 Sep 2017 06:51:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170918225552.GM10621@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v1 0/2] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, marcel@redhat.com

On 09/18/2017 07:55 PM, Eduardo Habkost wrote:
> On Mon, Sep 18, 2017 at 06:57:19PM -0300, Philippe Mathieu-Daudé wrote:
>> add a property to restrict the CPU for SoCs once on machine creation and avoid
>> duplicate code in each board.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> The valid_cpu_types approach implemented by Alistair is more
> generic:
>    Subject: [Qemu-devel] [RFC v1 0/2]  Add a valid_cpu_types property
>    Message-ID: <cover.1504656490.git.alistair.francis@xilinx.com>
> 
> With it, boards that don't support other CPUs just need to set
> valid_cpu_types = { default_cpu_type }.

Oh thank for pointing this out, I missed his series.

Many people waiting for Igor series to land ;)

Regards,

Phil.
