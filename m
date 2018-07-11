Received: from eggs.gnu.org ([2001:4830:134:3::10]:47958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdGZy-0007Zc-Uq
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdGZp-0003qM-90
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:58:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdGZo-0003q7-Sv
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:58:45 -0400
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
Date: Wed, 11 Jul 2018 16:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180711142819.GM31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 11/07/2018 16:28, Stefan Hajnoczi wrote:
>> + * build_driver_cmd_line(): builds the command line for the driver
>> + * @node. The node name must be a valid qemu identifier, since it
>> + * will be used to build the command line.
>> + *
>> + * It is also possible to pass an optional @args that will be
>> + * concatenated to the command line.
>> + *
>> + * For drivers, prepend -device to the driver name.
>> + */
>> +static void build_driver_cmd_line(QOSGraphNode *node, const char *arg=
s)
> Why is this called "driver" instead of "device"?
>=20

It's the command line that is needed for the driver to work; it can
include also e.g. a -netdev or -blockdev option, though the most common
case is to have just -device.

>> + *
>> + * QOSGraphObject also provides a destructor, used to deallocate the
>> + * after the test has been executed.
>> + */
>> +struct QOSGraphObject {
>> +    /* for produces, returns void * */
>> +    QOSGetDriver get_driver;
>=20
> Unused?
>=20
>> +    /* for contains, returns a QOSGraphObject * */
>> +    QOSGetDevice get_device;
>=20
> Unused?

What is unused?

Thanks,

Paolo
