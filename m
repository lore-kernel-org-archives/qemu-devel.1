Received: from eggs.gnu.org ([2001:4830:134:3::10]:42830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzs2X-0002KR-MJ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 18:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzs2U-0003VV-HG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 18:21:17 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:54245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzs2U-0003Uw-Cb
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 18:21:14 -0400
Received: by mail-qt0-x234.google.com with SMTP id 47so22119575qts.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 15:21:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
	<20171004130258.0a977151@nial.brq.redhat.com>
	<CAKmqyKPMJn92F1c+K8Wy_Ka6us0p1ver_0YQUcRdyr-TRoW_ew@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01e129b3-cd06-0a6b-59a1-7a01b95de879@amsat.org>
Date: Wed, 4 Oct 2017 19:21:09 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPMJn92F1c+K8Wy_Ka6us0p1ver_0YQUcRdyr-TRoW_ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

>>> +const char *netduino_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-m3"),
>> style nit,                               ^^^ put entries on new line with typical 4 space alignment
> 
> Do you mean like this?
> 
> const char *netduino_valid_cpus[] = {
>                                     ARM_CPU_TYPE_NAME("cortex-m3"),
>                                     ARM_CPU_TYPE_NAME("cortex-m4"),
>                                     NULL };

I suppose he meant:

static const char *netduino_valid_cpus[] = {
    ARM_CPU_TYPE_NAME("cortex-m3"),
    ARM_CPU_TYPE_NAME("cortex-m4"),
    NULL
};
