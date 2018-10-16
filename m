Received: from eggs.gnu.org ([2001:4830:134:3::10]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQan-0000AL-68
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQai-0006Zu-4B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCQah-0006ZP-Tl
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:45:00 -0400
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
	<94f7da55-eaa1-6e63-333c-894831b9d66e@redhat.com>
	<20181013033747.GC31060@habkost.net>
	<cac61fc7-e5f1-061b-fdab-23be1ef2f204@redhat.com>
	<92ecebc0-47dd-b80b-e59b-d0904fbafbb1@redhat.com>
	<20181015224036.GI31060@habkost.net>
	<a88876a0-ef9e-ea0c-7301-e8d56acaf49f@redhat.com>
	<CAAdtpL7L45mti6L30vodvPc6RhRXfw8s_R3fd_U0sjxG8dkCpg@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b777af45-78fc-9742-f40e-ceeac18a1ee4@redhat.com>
Date: Tue, 16 Oct 2018 10:44:47 -0400
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7L45mti6L30vodvPc6RhRXfw8s_R3fd_U0sjxG8dkCpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, ccarrara@redhat.com, Laszlo Ersek <lersek@redhat.com>



On 10/16/18 10:20 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>
>> This is possible with:
>>
>> #!/usr/bin/env python
>>
>> from avocado import main
>>
>> [test]
>>
>> if __name__ =3D=3D "__main__":
>>     main()
>=20
>=20
>> But is it really worth it?  IMO, it's not.
>>
>=20
> If that seamlessly uses the venv, I think it is.
>=20
>

I would not seamlessly use the venv, unless the venv is activated.

To me, we're clearly trying to stretch a very simple thing (the venv)
into something that should automagically do a lot more, but can't easily
do so.

- Cleber.
