Received: from eggs.gnu.org ([209.51.188.92]:50648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gmlNX-000671-Na
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gmlNU-0001sP-Bq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:13:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gmlNM-0001cf-N0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:13:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id y8so4411940wmi.4
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:13:01 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117092212.ccv7zv4snnuanxtw@sirius.home.kraxel.org>
	<75f937a5-4ab7-fdf5-f14c-e1ec87226c4a@gmail.com>
	<20190124074224.vuwxr6gith4txvmj@sirius.home.kraxel.org>
	<20190124111922.j2dduwjpm76con7w@sirius.home.kraxel.org>
Message-ID: <e48f9c9d-0953-feeb-4818-ad7f208c519c@gmail.com>
Date: Thu, 24 Jan 2019 21:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190124111922.j2dduwjpm76con7w@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/50] audio: reduce glob_audio_state
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 2019-01-24 12:19, Gerd Hoffmann wrote:
>   Hi,
> 
>> So, I think with the first part the only open issue is whenever we go
>> with the nested types (i.e. patch #1 as-is) or not.  Given that the
>> one-element-structs added in that patch will get additional fields I
>> think the nesting makes sense.
> 
> Spoke too soon: scripts/checkpatch.pl flags a bunch of codestyle issues.
> 

Most of them are about the code style of the old audio subsystem, I
fixed some of them but not everything.  IIRC last time it wasn't a
problem, but it was in 2015.  Should I go over them again and fix all of
them?

Regards,
Zoltan
