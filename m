Received: from eggs.gnu.org ([2001:4830:134:3::10]:41587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIoM-0002Yy-AB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIoI-0008CA-Bc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:38:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehIoI-00086r-65
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:38:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A1813E51D
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 17:38:05 +0000 (UTC)
References: <20180125143218.29528-1-kraxel@redhat.com>
	<20180125143218.29528-3-kraxel@redhat.com>
	<65124689-6705-71ee-561c-8d4b25b30e16@redhat.com>
	<20180201173529.GX22810@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6199d545-e7ae-ad95-6695-a63a714cb45c@redhat.com>
Date: Thu, 1 Feb 2018 12:37:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180201173529.GX22810@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/8] ui: convert the SDL2 frontend to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 01/02/2018 12:35, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Feb 01, 2018 at 12:28:02PM -0500, Paolo Bonzini wrote:
>> On 25/01/2018 09:32, Gerd Hoffmann wrote:
>>> --- a/include/ui/input.h
>>> +++ b/include/ui/input.h
>>> @@ -80,4 +80,7 @@ extern const guint16 qemu_input_map_qnum_to_qcode[]=
;
>>>  extern const guint qemu_input_map_qcode_to_linux_len;
>>>  extern const guint16 qemu_input_map_qcode_to_linux[];
>>
>> Is there any reason to use the length variables rather than just
>> ARRAY_SIZE()?  Coverity isn't able to see through the initializer and
>> incorrectly complains that
>=20
> ARRAY_SIZE can only be used if you can see the array variable
> initialization, but this is the header file so all we have is
> the extern declaration and thus the array size is unknown from
> the places that need to use the _len variable.
>=20
> We do in fact initalize the _len variable based on the ARRAY_SIZE,
> but that's in the .c files.

Would it make sense for keymap-gen to also generate the header file, so
that we can use an "extern const guint x[NNN]" declaration rather
instead of "x[]"?

Thanks,

Paolo
