Received: from eggs.gnu.org ([2001:4830:134:3::10]:59282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1di0lA-0004YC-Ut
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1di0l5-0003Zy-VI
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1di0l5-0003ZT-LP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:01:27 -0400
References: <20170815085732.9794-1-ldoktor@redhat.com>
	<20170815085732.9794-2-ldoktor@redhat.com>
	<87fuctm2ql.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <343636b3-85d2-cb2b-8975-dcc1bb0ddee1@redhat.com>
Date: Wed, 16 Aug 2017 18:01:10 +0200
MIME-Version: 1.0
In-Reply-To: <87fuctm2ql.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dwTeXCqTivewNT0fAvwrjIgoAsQ8rDlpC"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dwTeXCqTivewNT0fAvwrjIgoAsQ8rDlpC
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com,
 apahim@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <343636b3-85d2-cb2b-8975-dcc1bb0ddee1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
References: <20170815085732.9794-1-ldoktor@redhat.com>
 <20170815085732.9794-2-ldoktor@redhat.com>
 <87fuctm2ql.fsf@dusky.pond.sub.org>
In-Reply-To: <87fuctm2ql.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 15.8.2017 v 14:31 Markus Armbruster napsal(a):
> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>=20
>> No actual code changes, just several pylint/style fixes and docstring
>> clarifications.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++--------=
---------
>>  1 file changed, 53 insertions(+), 23 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 880e3e8..466aaab 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -23,8 +23,22 @@ import qmp.qmp
>>  class QEMUMachine(object):
>>      '''A QEMU VM'''
>> =20
>> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone, =
test_dir=3D"/var/tmp",
>> -                 monitor_address=3DNone, socket_scm_helper=3DNone, de=
bug=3DFalse):
>> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
>> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
>> +                 socket_scm_helper=3DNone, debug=3DFalse):
>> +        '''
>> +        Create a QEMUMachine object
>=20
> Initialize a QEMUMachine
>=20
> Rationale: it's __init__, not __create__, and "object" is redundant.
>=20

sure

>> +
>> +        @param binary: path to the qemu binary (str)
>=20
> Drop (str), because what else could it be?

it could be shlex.split of arguments to be passed to process. Anyway no s=
trong opinion here so I dropping it...

>=20
>> +        @param args: initial list of extra arguments
>=20
> If this is the initial list, then what's the final list?
>=20

It's the basic set of arguments which can be modified before the executio=
n. Do you think it requires additional explanation, or would you like to =
improve it somehow?

>> +        @param wrapper: list of arguments used as prefix to qemu bina=
ry
>> +        @param name: name of this object (used for log/monitor/... fi=
le names)
> prefix for socket and log file names (default: qemu-PID)
>=20

Sure, both make sense to me.

>> +        @param test_dir: base location to put log/monitor/... files i=
n
>=20
> where to create socket and log file
>=20
> Aside: test_dir is a lousy name.

Agree but changing names is tricky as people might be using kwargs to set=
 it. Anyway using your description here, keeping the possible rename for =
a separate patchset (if needed).

>=20
>> +        @param monitor_address: custom address for QMP monitor
>=20
> Yes, but what *is* a custom address?  Its user _base_args() appears to
> expect either a pair of strings (host, port) or a string filename.
>=20

If you insist I can add something like "a tuple(host, port) or string to =
specify path", but I find it unnecessary detailed...

>> +        @param socket_scm_helper: path to scm_helper binary (to forwa=
rd fds)
>=20
> What is an scm_helper, and why would I want to use it?
>=20

To forward a file descriptor. It's for example used in tests/qemu-iotests=
/045 or tests/qemu-iotests/147

>> +        @param debug: enable debug mode (forwarded to QMP helper and =
such)
>=20
> What is a QMP helper?  To what else is debug forwarded?
>=20

Debug is set in `self._debug` and can be consumed by anyone who has acces=
s to this variable. Currently that is the QMP, but people can inherit and=
 use that variable to adjust their behavior.

>> +        @note: Qemu process is not started until launch() is used.
>=20
> until launch().
>=20

OK

>> +        '''
>=20
> It's an improvement.
>=20
>>          if name is None:
>>              name =3D "qemu-%d" % os.getpid()
>>          if monitor_address is None:
>> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>>          self._qemu_log_path =3D os.path.join(test_dir, name + ".log")=

>>          self._popen =3D None
>>          self._binary =3D binary
>> -        self._args =3D list(args) # Force copy args in case we modify=
 them
>> +        self._args =3D list(args)     # Force copy args in case we mo=
dify them
>>          self._wrapper =3D wrapper
>>          self._events =3D []
>>          self._iolog =3D None
>>          self._socket_scm_helper =3D socket_scm_helper
>>          self._debug =3D debug
>> +        self._qmp =3D None
>> =20
>>      # This can be used to add an unused monitor instance.
>>      def add_monitor_telnet(self, ip, port):
>> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>>          if self._socket_scm_helper is None:
>>              print >>sys.stderr, "No path to socket_scm_helper set"
>>              return -1
>> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
>> +        if not os.path.exists(self._socket_scm_helper):
>>              print >>sys.stderr, "%s does not exist" % self._socket_sc=
m_helper
>>              return -1
>>          fd_param =3D ["%s" % self._socket_scm_helper,
>>                      "%d" % self._qmp.get_sock_fd(),
>>                      "%s" % fd_file_path]
>>          devnull =3D open('/dev/null', 'rb')
>> -        p =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsy=
s.stdout,
>> -                             stderr=3Dsys.stderr)
>> -        return p.wait()
>> +        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3D=
sys.stdout,
>> +                                stderr=3Dsys.stderr)
>> +        return proc.wait()
>> =20
>>      @staticmethod
>>      def _remove_if_exists(path):
>> @@ -99,8 +114,8 @@ class QEMUMachine(object):
>>          return self._popen.pid
>> =20
>>      def _load_io_log(self):
>> -        with open(self._qemu_log_path, "r") as fh:
>> -            self._iolog =3D fh.read()
>> +        with open(self._qemu_log_path, "r") as iolog:
>> +            self._iolog =3D iolog.read()
>> =20
>>      def _base_args(self):
>>          if isinstance(self._monitor_address, tuple):
>> @@ -114,8 +129,8 @@ class QEMUMachine(object):
>>                  '-display', 'none', '-vga', 'none']
>> =20
>>      def _pre_launch(self):
>> -        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addre=
ss, server=3DTrue,
>> -                                                debug=3Dself._debug)
>> +        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addre=
ss,
>> +                                                server=3DTrue, debug=3D=
self._debug)
>=20
> Recommend to break the line between the last two arguments.
>=20

I'm not used to do that, but I can most certainly do that. Do you want me=
 to change all places (eg. in the next chunk)

>> =20
>>      def _post_launch(self):
>>          self._qmp.accept()
>> @@ -131,9 +146,11 @@ class QEMUMachine(object):
>>          qemulog =3D open(self._qemu_log_path, 'wb')
>>          try:
>>              self._pre_launch()
>> -            args =3D self._wrapper + [self._binary] + self._base_args=
() + self._args
>> +            args =3D (self._wrapper + [self._binary] + self._base_arg=
s() +
>> +                    self._args)
>>              self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, s=
tdout=3Dqemulog,
>> -                                           stderr=3Dsubprocess.STDOUT=
, shell=3DFalse)
>> +                                           stderr=3Dsubprocess.STDOUT=
,
>> +                                           shell=3DFalse)
>>              self._post_launch()
>>          except:
>>              if self.is_running():
>> @@ -149,28 +166,34 @@ class QEMUMachine(object):
>>              try:
>>                  self._qmp.cmd('quit')
>>                  self._qmp.close()
>> -            except:
>> +            except:     # kill VM on any failure pylint: disable=3DW0=
702
>=20
> The bare except is almost certainly inappropriate.  Are you sure we
> should silence pylint?
>=20
> Note that there's another bare except in launch(), visible in the
> previous patch hunk.  I guess pylint is okay with that one because it
> re-throws the exception.
>=20
> In case we should silence pylint: what's the scope of this magic pylint=

> comment?  Can we use the symbolic disable=3Dbare-except?
>=20

Yep, we can use symbolic name as well. Well more appropriate would be to =
catch `SystemExit` and `KeyboardInterrupt`, treat them and raise them and=
 then ignore the rest of exceptions. I'll do that in the next version...

>>                  self._popen.kill()
>> =20
>>              exitcode =3D self._popen.wait()
>>              if exitcode < 0:
>> -                sys.stderr.write('qemu received signal %i: %s\n' % (-=
exitcode, ' '.join(self._args)))
>> +                sys.stderr.write('qemu received signal %i: %s\n'
>> +                                 % (-exitcode, ' '.join(self._args)))=

>>              self._load_io_log()
>>              self._post_shutdown()
>> =20
>>      underscore_to_dash =3D string.maketrans('_', '-')
>> +
>>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>>          '''Invoke a QMP command and return the result dict'''
>=20
> Make that "and return the response", because that's how
> docs/interop/qmp-spec.txt calls the thing.
>=20

Sure, no problem. I wanted to stress-out it's a dict and not encoded stri=
ng, but it's probably given by the context.

>>          qmp_args =3D dict()
>> -        for k in args.keys():
>> +        for key in args.keys():
>>              if conv_keys:
>> -                qmp_args[k.translate(self.underscore_to_dash)] =3D ar=
gs[k]
>> +                qmp_args[key.translate(self.underscore_to_dash)] =3D =
args[key]
>>              else:
>> -                qmp_args[k] =3D args[k]
>> +                qmp_args[key] =3D args[key]
>> =20
>>          return self._qmp.cmd(cmd, args=3Dqmp_args)
>> =20
>>      def command(self, cmd, conv_keys=3DTrue, **args):
>> +        '''
>> +        Invoke a QMP command and on success return result dict or on =
failure
>> +        raise exception with details.
>> +        '''
>=20
> I'm afraid "result dict" is wrong: it need not be a dict.  "on failure
> raise exception" adds precious little information, and "with details"
> adds none.
>=20
> Perhaps:
>=20
>            Invoke a QMP command.
>            On success return the return value.
>            On failure raise an exception.
>=20

That is quite more verbose than I'd like and result in the same (for non-=
native speaker), but I have no strong opinion here so changing it to your=
 version in v2.

> The last sentence is too vague, but it's hard to do better because...
>=20
>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>          if reply is None:
>>              raise Exception("Monitor is closed")
>=20
> ... we raise Exception!  This code is a *turd* (pardon my french), and
> PEP8 / pylint violations are the least of its problems.
>=20

Yep, adding rework-exceptions to my TODO list (for a future patchset)

>> @@ -193,15 +216,18 @@ class QEMUMachine(object):
>>          return events
>> =20
>>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
>> -        # Test if 'match' is a recursive subset of 'event'
>> -        def event_match(event, match=3DNone):
>> +        '''Wait for event in QMP, optionally filter results by match.=
'''
>=20
> What is match?
>=20
> name and timeout not worth mentioning?
>=20

IMO this does not require full-blown documentation, it's not really a use=
r-facing API and sometimes shorter is better. Anyway if you insist I can =
add full documentation of each parameter. I can even add `:type:` and `:r=
eturns:` and perhaps some `:warns:` and `:notes:` and I should descend an=
d note all the possible `:raises:`.

=2E.. the point I'm trying to make is I don't think it's necessary to go =
that much into details. Anyway if you think the params are necessary to l=
ist, then I can do that.

>> +        # Test if 'match' is a recursive subset of 'event'; skips bra=
nch
>> +        # processing on match's value `None`
>=20
> What's a "recursive subset"?  What's "branch processing"?
>=20
> There's an unusual set of quotes around `None`.
>=20

Basically I was surprised why this function exists as one can directly co=
mpare dicts. It's because it works as the stock dict compare only on valu=
e "None" it breaks and assumes that "branch" matches. That's why I listed=
 the example as I'm unsure how to explain it in a human language.

As for the `None`, in sphinx/doxygen it becomes "block" so I'm used to th=
ese, anyway people use `'`s and `"`s here so I'll change it in next versi=
on to be consistent.

>> +        #    {"foo": {"bar": 1} matches {"foo": None}
>=20
> Aha: None servers as wildcard.

Exactly.

>=20
>> +        def _event_match(event, match=3DNone):
>=20
> Any particular reason for renaming this function?
>=20

To emphasize it's internal, not a strong opinion but IMO looks better thi=
s way.

>>              if match is None:
>>                  return True
>> =20
>>              for key in match:
>>                  if key in event:
>>                      if isinstance(event[key], dict):
>> -                        if not event_match(event[key], match[key]):
>> +                        if not _event_match(event[key], match[key]):
>>                              return False
>>                      elif event[key] !=3D match[key]:
>>                          return False
>> @@ -212,18 +238,22 @@ class QEMUMachine(object):
>> =20
>>          # Search cached events
>>          for event in self._events:
>> -            if (event['event'] =3D=3D name) and event_match(event, ma=
tch):
>> +            if (event['event'] =3D=3D name) and _event_match(event, m=
atch):
>>                  self._events.remove(event)
>>                  return event
>> =20
>>          # Poll for new events
>>          while True:
>>              event =3D self._qmp.pull_event(wait=3Dtimeout)
>> -            if (event['event'] =3D=3D name) and event_match(event, ma=
tch):
>> +            if (event['event'] =3D=3D name) and _event_match(event, m=
atch):
>>                  return event
>>              self._events.append(event)
>> =20
>>          return None
>> =20
>>      def get_log(self):
>> +        '''
>> +        After self.shutdown or failed qemu execution this returns the=
 output
>=20
> Comma after execution, please.
>=20

OK

>> +        of the qemu process.
>> +        '''
>>          return self._iolog
>=20
> I understand this code was factored out of qemu-iotests for use by
> qtest.py.  That's okay, but I'd rather not serve as its maintainer.
> -E2MUCH...
>=20

Yep, anyway it contains several useful methods/helpers and fixing basic i=
ssues is the simplest way to get to know the code (and the submitting pro=
cess). Thank you for your time.

Regards,
Luk=C3=A1=C5=A1


--dwTeXCqTivewNT0fAvwrjIgoAsQ8rDlpC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZlGxGExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGA
VggAlkCQKYXVG8YM/ThT2mQ2uG+qvBMPRMBtJLunTGZ2bIgAtiykhDt8oEZaBcQ2
6bpFwrUbIqwhk8f4etVs0/+Fg7V7Oy7doQ0bwTRs3xr+hTPZ4TCvlL5Mq353jidU
Tm9UMaGm+AlOeAtFBBuMPJB33a4Q/pC0Dc1loZqvARRF4mBZ1YDnrswBerzZnYrY
wXyrfzfHc+luMBPLeBoLKbOniUKAOqDc4d0AgoctqjdNJfpRfbo5E9kM26c03VM3
k8mvw1NeQ1BYDoXYSMQgawJw24ES3dx7KVDz98mXWNZfDlTO/iVkDUX0MTZ2Zjuo
dIMmgKsZQYDF/kM6FkGVcWKvmg==
=jJpy
-----END PGP SIGNATURE-----

--dwTeXCqTivewNT0fAvwrjIgoAsQ8rDlpC--
