Received: from eggs.gnu.org ([2001:4830:134:3::10]:35207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eOQCQ-0003NF-Ss
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eOQCN-0007Ls-Mu
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:40:58 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eOQCN-0007L3-Co
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:40:55 -0500
Received: by mail-wr0-x244.google.com with SMTP id g53so18057188wra.2
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 07:40:55 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<151299976659.23197.13468748846815959484@bfc911d3884a>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <151299976659.23197.13468748846815959484@bfc911d3884a>
Date: Mon, 11 Dec 2017 15:40:52 +0000
Message-ID: <87po7l8e7v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/19] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com


no-reply@patchew.org writes:

> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:

FWIW these are either:

  - misidentified "spaces prohibited around that ':' (ctx:WxW)" for bitfiel=
ds
  - existing softfloat code that has moved
  - two lines that just edge over the 80 char limit

> Checking PATCH 9/19: fpu/softfloat: define decompose structures...
> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #54: FILE: fpu/softfloat.c:210:
> +    uint64_t frac   : 64;
>                      ^
>
> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #55: FILE: fpu/softfloat.c:211:
> +    int exp         : 32;
>                      ^
>
> ERROR: space prohibited before that ':' (ctx:WxW)
> #57: FILE: fpu/softfloat.c:213:
> +    int             : 23;
>                      ^
>
> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #58: FILE: fpu/softfloat.c:214:
> +    bool sign       : 1;
>                      ^
>
> total: 4 errors, 0 warnings, 84 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 10/19: fpu/softfloat: re-factor add/sub...
> WARNING: line over 80 characters
> #140: FILE: fpu/softfloat.c:364:
> +                                                   const decomposed_para=
ms *parm)
>
> total: 0 errors, 1 warnings, 937 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 11/19: fpu/softfloat: re-factor mul...
> Checking PATCH 12/19: fpu/softfloat: re-factor div...
> Checking PATCH 13/19: fpu/softfloat: re-factor muladd...
> Checking PATCH 14/19: fpu/softfloat: re-factor round_to_int...
> WARNING: line over 80 characters
> #90: FILE: fpu/softfloat.c:1252:
> +                inc =3D ((a.frac & roundeven_mask) !=3D frac_lsbm1 ? fra=
c_lsbm1 : 0);
>
> total: 0 errors, 1 warnings, 329 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 15/19: fpu/softfloat: re-factor float to int/uint...
> ERROR: space prohibited after that '-' (ctx:WxW)
> #55: FILE: fpu/softfloat.c:1347:
> +            return r < - (uint64_t) INT64_MIN ? -r : INT64_MIN;
>                         ^
>
> WARNING: line over 80 characters
> #91: FILE: fpu/softfloat.c:1383:
> +int ## isz ## _t float ## fsz ## _to_int ## isz(float ## fsz a, float_st=
atus *s) \
>
> WARNING: line over 80 characters
> #171: FILE: fpu/softfloat.c:1463:
> +uint ## isz ## _t float ## fsz ## _to_uint ## isz(float ## fsz a, float_=
status *s) \
>
> ERROR: space prohibited after that open parenthesis '('
> #711: FILE: fpu/softfloat.c:3410:
> +    if (    ( ( extractFloat32Exp( a ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( a ) )
>
> ERROR: space prohibited before that close parenthesis ')'
> #711: FILE: fpu/softfloat.c:3410:
> +    if (    ( ( extractFloat32Exp( a ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( a ) )
>
> ERROR: space prohibited after that open parenthesis '('
> #712: FILE: fpu/softfloat.c:3411:
> +         || ( ( extractFloat32Exp( b ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( b ) )
>
> ERROR: space prohibited before that close parenthesis ')'
> #712: FILE: fpu/softfloat.c:3411:
> +         || ( ( extractFloat32Exp( b ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( b ) )
>
> ERROR: space prohibited after that open parenthesis '('
> #733: FILE: fpu/softfloat.c:3419:
> +    aSign =3D extractFloat32Sign( a );
>
> ERROR: space prohibited before that close parenthesis ')'
> #733: FILE: fpu/softfloat.c:3419:
> +    aSign =3D extractFloat32Sign( a );
>
> ERROR: space prohibited after that open parenthesis '('
> #734: FILE: fpu/softfloat.c:3420:
> +    bSign =3D extractFloat32Sign( b );
>
> ERROR: space prohibited before that close parenthesis ')'
> #734: FILE: fpu/softfloat.c:3420:
> +    bSign =3D extractFloat32Sign( b );
>
> WARNING: line over 80 characters
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
>
> ERROR: spaces required around that '<<' (ctx:VxV)
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
>                                                                      ^
>
> ERROR: space prohibited after that open parenthesis '('
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
>
> ERROR: space prohibited before that close parenthesis ')'
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
>
> ERROR: trailing statements should be on next line
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
>
> ERROR: braces {} are necessary for all arms of this statement
> #737: FILE: fpu/softfloat.c:3423:
> +    if ( aSign !=3D bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<=
1 ) !=3D 0 );
> [...]
>
> ERROR: space prohibited after that open parenthesis '('
> #738: FILE: fpu/softfloat.c:3424:
> +    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
>
> ERROR: space prohibited before that close parenthesis ')'
> #738: FILE: fpu/softfloat.c:3424:
> +    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
>
> ERROR: space prohibited after that open parenthesis '('
> #798: FILE: fpu/softfloat.c:3440:
> +    if (    ( ( extractFloat32Exp( a ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( a ) )
>
> ERROR: space prohibited before that close parenthesis ')'
> #798: FILE: fpu/softfloat.c:3440:
> +    if (    ( ( extractFloat32Exp( a ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( a ) )
>
> ERROR: space prohibited after that open parenthesis '('
> #799: FILE: fpu/softfloat.c:3441:
> +         || ( ( extractFloat32Exp( b ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( b ) )
>
> ERROR: space prohibited before that close parenthesis ')'
> #799: FILE: fpu/softfloat.c:3441:
> +         || ( ( extractFloat32Exp( b ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( b ) )
>
> total: 20 errors, 3 warnings, 1065 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 16/19: fpu/softfloat: re-factor int/uint to float...
> Checking PATCH 17/19: fpu/softfloat: re-factor scalbn...
> Checking PATCH 18/19: fpu/softfloat: re-factor minmax...
> WARNING: line over 80 characters
> #122: FILE: fpu/softfloat.c:1764:
> +float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b, float=
_status *s) \
>
> total: 0 errors, 1 warnings, 266 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 19/19: fpu/softfloat: re-factor compare...
> WARNING: line over 80 characters
> #88: FILE: fpu/softfloat.c:1864:
> +int float ## sz ## _compare_quiet(float ## sz a, float ## sz b, float_st=
atus *s) \
>
> total: 0 errors, 1 warnings, 155 lines checked
<snip>

--
Alex Benn=C3=A9e
