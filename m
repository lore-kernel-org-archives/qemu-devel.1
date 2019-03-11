Received: from eggs.gnu.org ([209.51.188.92]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3JTG-0008R5-Ms
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3JRO-0004Ju-2Y
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3JRN-0004JE-Q1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:49:58 -0400
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<ed8793ce-cc5f-a506-2bdc-a39e9fc79cc7@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <07100472-e75f-88c7-6740-21a56e225f80@redhat.com>
Date: Mon, 11 Mar 2019 12:49:50 +0100
MIME-Version: 1.0
In-Reply-To: <ed8793ce-cc5f-a506-2bdc-a39e9fc79cc7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Edgar Iglesias <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 08/03/2019 17.11, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Markus,
>=20
> [Asking again from the correct series thread]
>=20
> On 1/3/18 10:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Use Base64 to serialize the binary blobs in JSON.
>> So far at most 512 bytes will be transfered, which result
>> in a 684 bytes payload.
>> Since this command is intented for qtesting, it is acceptable.
>=20
> Any comment regarding QMP for this patch?

Is this useful for anybody else than qtest? If not, I think this should
rather go into the qtest protocol instead, since QMP is our "public"
protocol.

>> diff --git a/hw/sd/sdbus-qmp.c b/hw/sd/sdbus-qmp.c
>> new file mode 100644
>> index 0000000000..8c4b6f2aee
>> --- /dev/null
>> +++ b/hw/sd/sdbus-qmp.c
>> @@ -0,0 +1,65 @@
>> +/*
>> + * SD card bus QMP debugging interface (for QTesting).
>> + *
>> + * Copyright (c) 2017 ?

Weird line. Add you name here ?

 Thomas
