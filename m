Received: from eggs.gnu.org ([2001:4830:134:3::10]:36378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCEv-0002rx-7n
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCEp-00074I-JZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:36:29 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCEp-000740-CU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:36:23 -0500
Received: by mail-qt0-x244.google.com with SMTP id d54so19100387qtd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:36:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
	<CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3dc09f5a-241a-728f-2051-393010049f1d@amsat.org>
Date: Thu, 18 Jan 2018 12:36:19 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/19] machine queue, 2018-01-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 01/18/2018 12:22 PM, Peter Maydell wrote:
> On 18 January 2018 at 02:09, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>>
>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>
>> for you to fetch changes up to 901cc8d31f36ac82824ab68f656ab7050404100c:
>>
>>   fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-17 23:04:37 -0200)
>>
>> ----------------------------------------------------------------
>> machine queue, 2018-01-18
>>
>> ----------------------------------------------------------------
> 
> Hi. I'm afraid this doesn't build on 32-bit hosts, due to a
> format string problem:
> 
> In file included from /home/peter.maydell/qemu/exec.c:20:0:
> /home/peter.maydell/qemu/exec.c: In function 'file_ram_alloc':
> /home/peter.maydell/qemu/include/qapi/error.h:162:25: error: format
> '%llx' expects argument of type 'long long unsigned int', but argument
> 7 has type 'size_t {aka unsigned int}' [-Werror=format=]
>                          (fmt), ## __VA_ARGS__)
>                          ^
> /home/peter.maydell/qemu/exec.c:1616:9: note: in expansion of macro 'error_setg'
>          error_setg(errp, "aligment 0x%" PRIx64
>          ^

Eduardo you can quickly check that running:

  $ make docker-test-build@debian-win32-cross
  (or use the debian-armel-cross image, but win32 is often weirder)

I hope one day compiler get smart enough to automatically fix those
mistakes :)
