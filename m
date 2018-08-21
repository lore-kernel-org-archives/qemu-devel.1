Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs7Sa-0002fZ-GP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs7SV-0001dp-27
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:16:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fs7SU-0001dN-Pc
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:16:34 -0400
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
	<20180820024504.GA7953@xz-mi>
	<CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
	<20180821062951.GE19915@xz-mi>
	<CAJ+F1C+qTV6gQa6SZJ_HLUP1YO0Nm2C-momg0nAZcV6TWPaREw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3842a5df-b3ed-08b3-b627-a89cd3c7c1ce@redhat.com>
Date: Tue, 21 Aug 2018 16:16:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+qTV6gQa6SZJ_HLUP1YO0Nm2C-momg0nAZcV6TWPaREw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 21/08/2018 16:04, Marc-Andr=C3=A9 Lureau wrote:
>> If you don't like the way I proposed, another thing I am
>> thinking is that whether we can assign the gcontext for the chardev
>> backend before initialization of it (or by parsing the backend &
>> frontend relationships before init of backends), then we assure that
>> we never change the gcontext of any chardev backends.  Though that
> Yes, I think that's a cleaner solution. I suggested to use an iothread
> argument in the cover letter.

That would be nice, but isn't it already too late for the monitor chardev=
?

In any case, I don't see a reason to dislike this patch, especially
since it comes with a testcase.

Paolo
