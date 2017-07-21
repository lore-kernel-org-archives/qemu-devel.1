Received: from eggs.gnu.org ([2001:4830:134:3::10]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYSSb-0000FA-Kh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYSSX-0002Qq-K0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYSSX-0002QD-98
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B31B7EBD3
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 07:34:48 +0000 (UTC)
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-2-apahim@redhat.com>
	<87inin1g78.fsf@dusky.pond.sub.org>
	<CALAZnb1uWT__Pnd-zeP3_L+t+JDtK42+KHV9qo_r6qXWs4P64w@mail.gmail.com>
	<87vamnuovc.fsf@dusky.pond.sub.org>
	<20170720174905.GQ2757@localhost.localdomain>
	<CALAZnb3W+NnjKafbmZ1Bn77Dm=YqfkVDKinz+VU2BF7D-x-7mA@mail.gmail.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <7550b799-e417-5dac-40b6-d2207fc9d5d2@redhat.com>
Date: Fri, 21 Jul 2017 09:34:37 +0200
MIME-Version: 1.0
In-Reply-To: <CALAZnb3W+NnjKafbmZ1Bn77Dm=YqfkVDKinz+VU2BF7D-x-7mA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u8ODAokuhrpRtbmqXG51qRFkOTUfHPE8X"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u8ODAokuhrpRtbmqXG51qRFkOTUfHPE8X
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Amador Pahim <apahim@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <7550b799-e417-5dac-40b6-d2207fc9d5d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: fix is_running()
References: <20170720091902.22476-1-apahim@redhat.com>
 <20170720091902.22476-2-apahim@redhat.com>
 <87inin1g78.fsf@dusky.pond.sub.org>
 <CALAZnb1uWT__Pnd-zeP3_L+t+JDtK42+KHV9qo_r6qXWs4P64w@mail.gmail.com>
 <87vamnuovc.fsf@dusky.pond.sub.org>
 <20170720174905.GQ2757@localhost.localdomain>
 <CALAZnb3W+NnjKafbmZ1Bn77Dm=YqfkVDKinz+VU2BF7D-x-7mA@mail.gmail.com>
In-Reply-To: <CALAZnb3W+NnjKafbmZ1Bn77Dm=YqfkVDKinz+VU2BF7D-x-7mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 22:14 Amador Pahim napsal(a):
> On Thu, Jul 20, 2017 at 7:49 PM, Eduardo Habkost <ehabkost@redhat.com> =
wrote:
>> On Thu, Jul 20, 2017 at 05:09:11PM +0200, Markus Armbruster wrote:
>>> Amador Pahim <apahim@redhat.com> writes:
>>>
>>>> On Thu, Jul 20, 2017 at 1:49 PM, Markus Armbruster <armbru@redhat.co=
m> wrote:
>>>>> Amador Pahim <apahim@redhat.com> writes:
>>>>>
>>>>>> Current implementation is broken. It does not really test if the c=
hild
>>>>>> process is running.
>>>>>
>>>>> What usage exactly is broken by this?  Got a reproducer for me?
>>>>
>>>> Problem is that 'returncode' is not set without a calling
>>>> poll()/wait()/communicate(), so it's only useful to test if the
>>>> process is running after such calls. But if we use 'poll()' instead,=

>>>> it will, according to the docs, "Check if child process has
>>>> terminated. Set and return returncode attribute."
>>>>
>>>> Reproducer is:
>>>>
>>>>  >>> import subprocess
>>>>  >>> devnull =3D open('/dev/null', 'rb')
>>>>  >>> p =3D subprocess.Popen(['qemu-system-x86_64', '-broken'],
>>>> stdin=3Ddevnull, stdout=3Ddevnull, stderr=3Ddevnull, shell=3DFalse)
>>>>  >>> print p.returncode
>>>>  None
>>>>  >>> print p.poll()
>>>>  1
>>>>  >>> print p.returncode
>>>>  1
>>>>
>>>>>> The Popen.returncode will only be set after by a poll(), wait() or=

>>>>>> communicate(). If the Popen fails to launch a VM, the Popen.return=
code
>>>>>> will not turn to None by itself.
>>>>>
>>>>> Hmm.  What is the value of .returncode then?
>>>>
>>>> returncode starts with None and becomes the process exit code when t=
he
>>>> process is over and one of that three methods is called (poll(),
>>>> wait() or communicate()).
>>>>
>>>> There's an error in my description though. The correct would be: "Th=
e
>>>> Popen.returncode will only be set after a call to poll(), wait() or
>>>> communicate(). If the Popen fails to launch a VM, the Popen.returnco=
de
>>>> will not turn from None to the actual return code by itself."
>>>
>>> Suggest to add ", and is_running() continues to report True".
>>>
>>>>>> Instead of using Popen.returncode, let's use Popen.poll(), which
>>>>>> actually checks if child process has terminated.
>>>>>>
>>>>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>>> ---
>>>>>>  scripts/qemu.py | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>>> index 880e3e8219..f0fade32bd 100644
>>>>>> --- a/scripts/qemu.py
>>>>>> +++ b/scripts/qemu.py
>>>>>> @@ -86,7 +86,7 @@ class QEMUMachine(object):
>>>>>>              raise
>>>>>>
>>>>>>      def is_running(self):
>>>>>> -        return self._popen and (self._popen.returncode is None)
>>>>>> +        return self._popen and (self._popen.poll() is None)
>>>>>>
>>
>> After re-reading shutdown(), I think this is _not_ OK: if
>> is_running() return False before we call .wait(), we will never
>> load the log file or run _post_shutdown() if QEMU exits between
>> the launch() and shutdown() calls.
>=20
> Yes, I just noticed that while cleaning up the code.
>=20
>>
>> Yes, it's fragile.
>>
>> The root problem on both launch() and shutdown() seems to be
>> coupling the external "is QEMU running?" state with the internal
>> "did we load the log file and ran _post_shutdown() already?"
>> state.
>>
>> I see two possible approaches for this:
>>
>> 1) Benefit from the fact that the internal Popen state will not
>>    change under our feet unless we explicitly call
>>    poll()/wait()/etc, and keep the existing code.  (Not my
>>    favorite option)
>>
>> 2) Rewrite the code so that we don't depend on the subtle Popen
>>    internal state rules, and track our own internal state in
>>    a QEMUMachine attribute.  e.g.:
>=20
> +1 for this approach. I'm working on something similar, thanks for the
> detailed "e.g." code here.
>=20
>>
>>     def _handle_shutdown(self):
>>         '''Load log file and call _post_shutdown() hook if necessary''=
'
>>         # Must be called only after QEMU actually exited.
>>         assert not self.is_running()
>>         if self._shutdown_pending:
>>             if self.exitcode() < 0:
>>                 sys.stderr.write('qemu received signal %i: %s\n' % (-e=
xitcode, ' '.join(self._args)))
>>             self._load_io_log()
>>             self._post_shutdown()
>>             self._shutdown_pending =3D False
>>
>>     def _terminate(self):
>>         '''Terminate QEMU if it's still running'''
>>         if self.is_running():
>>             try:
>>                 self._qmp.cmd('quit')
>>                 self._qmp.close()
>>             except:
>>                 self._popen.kill()
>>                 self._popen.wait()
>>
>>     def _launch(self):
>>         '''Launch the VM and establish a QMP connection'''
>>         devnull =3D open('/dev/null', 'rb')
>>         qemulog =3D open(self._qemu_log_path, 'wb')
>>         self._shutdown_pending =3D True
>>         self._pre_launch()
>>         args =3D self._wrapper + [self._binary] + self._base_args() + =
self._args
>>         self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, stdout=
=3Dqemulog,
>>                                        stderr=3Dsubprocess.STDOUT, she=
ll=3DFalse)
>>         self._post_launch()
>>
>>     def launch(self):
>>         try:
>>             self._launch()
>>         except:
>>             self._terminate()
>>             self._handle_shutdown()
>>             raise
>>
>>     def shutdown(self):
>>         '''Terminate the VM and clean up'''
>>         self._terminate()
>>         self._handle_shutdown()
>>
This part also caught my attention and I also meant to improve it when th=
is series is merged. Anyway let's state my suggestions here, take it or l=
et it go:

1. `get_log` should check whether `self._iolog` is `None` and then it sho=
uld check for process status
2. the `self._iolog` is `None` is the indication whether `shutdown` was c=
alled or not (not whether the process exists or not)
3. add `__del__` to cleanup in case one forgets to call `shutdown` (curre=
ntly the files and processes are left behind)
4. use `name =3D "qemu-%d-%d" % (os.getpid(), id(self))` to allow multipl=
e instances with default name at the same time.


Also I just realized that even with just this patch (as is) files/process=
es can be left behind:

    >>> import qemu, os
    >>> a=3Dqemu.QEMUMachine("/usr/bin/qemu-kvm", debug=3DTrue)
    >>> a.launch()
    QMP:>>> {'execute': 'qmp_capabilities'}
    QMP:<<< {u'return': {}}
    >>> a.is_running()
    False
    >>> a.shutdown()
    >>> os.path.exists(a._qemu_log_path)
    True

Before this patch it worked well as (as Eduardo mentioned) the `is_runnin=
g` was tracing internal state, not the process state.

Regards,
Luk=C3=A1=C5=A1

>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>>>>>>      def exitcode(self):
>>>>>>          if self._popen is None:
>>>>>                return None
>>>>>            return self._popen.returncode
>>>>>
>>>>> Why is this one safe?
>>>>
>>>> Here it's used just to retrieve the value from the Popen.returncode.=

>>>> It's not being used to check whether the process is running or not.
>>>
>>> If self._popen is not None, we return self._popen.returncode.  It's N=
one
>>> if .poll() etc. haven't been called.  Can this happen?  If not, why n=
ot?
>>> If yes, why is returning None then okay?
>>
>> It can't happen because the only caller of exitcode()
>> (device-crash-test) calls it immediately after shutdown().  But
>> it would be nice to make exitcode() behavior consistent with
>> is_running().
>>
>> --
>> Eduardo



--u8ODAokuhrpRtbmqXG51qRFkOTUfHPE8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZca6NExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHc
RggAwYl92ZmdptLMPzY2iyFARbd7QtlkwUdz9T5spjzqhWAqfxZ2Hz7hXQCYAPak
TcF3rhRmr0Hna6sVvtv6GfpqggZRC+uRnzclHSnl2PQfXgA/Ngxi9Iw99yEyYKhf
i/0vN2+1g5o5Z6abszgLUCRGaMGBXXIGmptWzXN2RLVy1j8Wrg97KBz8gySUv4vu
D+3S11ua3DkyMu4aEdkg4xEW7gMgF2J2EEnRn8HsRbV/AYHvGa6pWDpuGNnb2/Go
TPRgHJ+JLRrMDrrOsg/0+XzUouxhUp0MJVsOiQWK3V8Z7P2iXdeFGVkwxbE/hnp7
JPevXz7DDK8t+FWt6p/2MUd3fw==
=VUOM
-----END PGP SIGNATURE-----

--u8ODAokuhrpRtbmqXG51qRFkOTUfHPE8X--
