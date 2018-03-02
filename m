Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eriHC-0004zY-Rd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eriHC-0004ny-1x
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eriHB-0004n2-U8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:58 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<20180301092046.7cb959d8@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7864bf9f-5726-1cdc-06a5-35ab51679568@redhat.com>
Date: Fri, 2 Mar 2018 11:50:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180301092046.7cb959d8@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Cc: Julia Suvorova <jusual@mail.ru>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Cornelia Huck <cohuck@redhat.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>

On 01/03/2018 17:20, Alex Williamson wrote:
>> basename(3) and dirname(3) modify their argument and may return
>> pointers to statically allocated memory which may be overwritten by
>> subsequent calls.
>> g_path_get_basename and g_path_get_dirname have no such issues, and
>> therefore more preferable.
>
> I think it's quite a bit arguable whether it's preferable, afaict there
> are no bugs fixed here.  The basic functions are being used correctly
> and are more conservative of memory usage than the glib variants.  In
> several cases below the basic functions seem far more efficient and we
> don't need to worry about freeing unnecessarily allocated memory, the
> diffstat seems to attest to this.  Is the inefficiency and possibility
> of leaking unintentionally allocated memory a statistical improvement
> over the claimed perils of these absolutely standard and well known
> functions?
>=20
> I know mine is a losing battle against glib, but the changelog might as
> well just say "Succumb to glib" because I fail to see that there's
> actually an improvement here.  If Paolo wants to take this,
>=20
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Fair enough, I'll apply only the obvious cases like g_strdup(basename()).

Paolo
