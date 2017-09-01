Received: from eggs.gnu.org ([2001:4830:134:3::10]:40907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrdg-0000wi-Gt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrdb-0007Zg-VL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:30:00 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrdb-0007ZQ-Rn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:29:55 -0400
Received: by mail-qk0-x244.google.com with SMTP id l65so840687qkc.3
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 12:29:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<c751fc1d-602a-25ed-edb9-84ccdaeb2ecb@amsat.org>
	<20170830033445.GE4208@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02eb8166-d0a4-a0e9-ec82-bc45a3626fd1@amsat.org>
Date: Fri, 1 Sep 2017 16:29:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170830033445.GE4208@lemon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/30/2017 12:34 AM, Fam Zheng wrote:
> On Tue, 08/29 14:34, Philippe Mathieu-Daudé wrote:
>>> +        self._args = [ \
>>> +            "-nodefaults", "-m", "2G",
>>> +            "-cpu", "host",
>>> +            "-netdev", "user,id=vnet,hostfwd=:0.0.0.0:0-:22",
>>> +            "-device", "virtio-net-pci,netdev=vnet",
>>> +            "-vnc", ":0,to=20",
>>> +            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
>>> +        if vcpus:
>>> +            self._args += ["-smp", str(vcpus)]
>>
>> What about enabling mttcg which isn't default?
>>
>>              self._args += ["--accel", "tcg,thread=multi"]
> 
> Any specific reason to enable it? I think it is not available on older QEMU.

Neither is dynamic portfwd :)

I see 2 reasons:
- faster test
- cover mttcg

> 
>>
>>> +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
>>> +            self._args += ["-enable-kvm"]
>>> +        else:
>>> +            logging.info("KVM not available, not using -enable-kvm")
>>> +        self._data_args = []
>> [...]
> 
> Fam
> 
