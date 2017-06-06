Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIBso-0003Vm-Hi
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIBsn-0000wM-Ms
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:38:42 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIBsn-0000vH-Gk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:38:41 -0400
Received: by mail-wm0-x22c.google.com with SMTP id d73so45743182wma.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 03:38:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALfaEa0T+rcZjmehm=Rdr+NOApTOKsizpCWcQ6ssErhU=nuUTA@mail.gmail.com>
References: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
	<20170606092831.GA8013@stefanha-x1.localdomain>
	<CALfaEa0T+rcZjmehm=Rdr+NOApTOKsizpCWcQ6ssErhU=nuUTA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Jun 2017 11:38:39 +0100
Message-ID: <CAJSP0QXffef=Ds7SeTFeCWi7iAjjUarUBzvc+hzLc6AhzQwMsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruno Dominguez <bru.dominguez@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Jun 6, 2017 at 10:45 AM, Bruno Dominguez
<bru.dominguez@gmail.com> wrote:
> 2017-06-06 10:28 GMT+01:00 Stefan Hajnoczi <stefanha@gmail.com>:
>> On Fri, Jun 02, 2017 at 02:07:26PM +0100, Bruno Dominguez wrote:
>>> @@ -1489,37 +1498,6 @@ if test "$bogus_os" = "yes"; then
>>>      error_exit "Unrecognized host OS $targetos"
>>>  fi
>>>
>>> -# Check that the C++ compiler exists and works with the C compiler
>>> -if has $cxx; then
>>> -    cat > $TMPC <<EOF
>>> -int c_function(void);
>>> -int main(void) { return c_function(); }
>>> -EOF
>>> -
>>> -    compile_object
>>> -
>>> -    cat > $TMPCXX <<EOF
>>> -extern "C" {
>>> -   int c_function(void);
>>> -}
>>> -int c_function(void) { return 42; }
>>> -EOF
>>> -
>>> -    update_cxxflags
>>> -
>>> -    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
>>> -        # C++ compiler $cxx works ok with C compiler $cc
>>> -        :
>>> -    else
>>> -        echo "C++ compiler $cxx does not work with C compiler $cc"
>>> -        echo "Disabling C++ specific optional code"
>>> -        cxx=
>>> -    fi
>>> -else
>>> -    echo "No C++ compiler available; disabling C++ specific optional code"
>>> -    cxx=
>>> -fi
>>> -
>>
>> Why move this code?
>>
>
> the configure file adds "-fPIE -DPIE" to QEMU_CFLAGS around line 1570.
> Where QEMU_CXXFLAGS is placed is not taken it, hence this flag is not
> tested with the c++ compiler and breaks the build later on for not
> existing. Because QEMU_CXXFLAGS was reassigned again in rules.mak this
> was hidden.

Thanks for explaining.

Stefan
